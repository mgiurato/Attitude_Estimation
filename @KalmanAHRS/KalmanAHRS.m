classdef KalmanAHRS < handle
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % MEKF AHRS                      %
    % Author: M.Giurato              %
    % Date: 09/09/2016               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Public properties
    properties (Access = public)
        SamplePeriod = 1/100;       % [s] Sample time
        Quaternion = [0 0 0 1]';    % output quaternion describing the attitude of the body referred to the inertial system
        bias = [0 0 0]';            % estimated bias
        dalpha = [0 0 0]';          % Attitude estimation error initial condition
        P = (1e-5)*eye(6);          % Covariance matrix initial condition
        Sigma_acc = 1;              % Sigma accelerometer
        Sigma_mag = 1;              % Sigma magnetometer
        Sigma_u = 1;                % Sigma rate random walk
        Sigma_v = 1;                % Sigma angle random walk
    end
    
    %% Public methods
    methods (Access = public)
        function obj = KalmanAHRS(varargin)
            for i = 1:2:nargin
                if  strcmp(varargin{i}, 'SamplePeriod'), obj.SamplePeriod = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Quaternion'), obj.Quaternion = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Sigma_acc'), obj.Sigma_acc = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Sigma_mag'), obj.Sigma_mag = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Sigma_u'), obj.Sigma_u = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Sigma_v'), obj.Sigma_v = varargin{i+1};
                elseif  strcmp(varargin{i}, 'P'), obj.P = varargin{i+1};
                else error('Invalid argument');
                end
            end;
        end
        
        function obj = Update(obj, Gyroscope, Accelerometer, Magnetometer)
            % Constant parameters renamed for simplicity
            I3 = eye(3);
            I6 = eye(6);
            O3 = zeros(3);
            
            % Normalise accelerometer measurement
            if(norm(Accelerometer) == 0), return; end       % handle NaN
            b_acc = Accelerometer / norm(Accelerometer);    % normalise magnitude
            
            % Normalise magnetometer measurement
            if(norm(Magnetometer) == 0), return; end        % handle NaN
            b_mag = Magnetometer / norm(Magnetometer);      % normalise magnitude
            
            % Propagated value from previous step
            betakm = obj.bias;
            qkm = obj.Quaternion;
            Pkm = obj.P;
            deltaXkm = zeros(6,1);
            
           % Compute attitude matrix
            Akm = quatToAtt(qkm);
            
            %% Correction (measurement update)
            for i = 1:1:2
                if i == 1
                    % Reference direction of Earth's gravitational field
                    r_acc = [ 0  ;
                              0  ;
                              1 ];
                    Aqmr = Akm * r_acc;
                    b = b_acc;
                    R = obj.Sigma_acc^2 * I3;
                    
                    % Sensitivity Matrix
                    Aqmrx = [     0   -Aqmr(3)  Aqmr(2) ;
                              Aqmr(3)    0     -Aqmr(1) ;
                             -Aqmr(2)  Aqmr(1)    0    ];
                    Hk = [Aqmrx O3];
                    
                    % Gain
                    Kk = (Pkm * Hk')/(Hk * Pkm * Hk' + R);
                    
                    % Update Covariance
                    Pkp = (I6 - Kk * Hk) * Pkm * (I6 - Kk * Hk)' + Kk * R * Kk';
                    
                    % Update state
                    epk = b - Aqmr;
                    yk = epk - Hk * deltaXkm;
                    deltaXkp = (deltaXkm + Kk * yk);
                    
                    Pkm = Pkp;
                    deltaXkm = deltaXkp;
                    
                elseif i == 2
                    % Reference direction of Earth's magnetic feild
                    h = Akm' * Magnetometer;
                    r_mag = [sqrt(h(1)^2 + h(2)^2) ;
                                      0            ;
                                     h(3)         ];
                    Aqmr = Akm * r_mag;
                    b = b_mag;
                    R = obj.Sigma_mag^2*I3;
                    
                    % Sensitivity Matrix
                    Aqmrx = [    0    -Aqmr(3)  Aqmr(2) ;
                              Aqmr(3)    0     -Aqmr(1) ;
                             -Aqmr(2)  Aqmr(1)    0    ];
                    Hk = [Aqmrx O3];
                    
                    % Gain
                    Kk = (Pkm*Hk')/(Hk*Pkm*Hk' + R);
                    
                    % Update Covariance
                    Pkp = (I6 - Kk*Hk)*Pkm*(I6 - Kk*Hk)' + Kk*R*Kk';
                    
                    % Update state
                    epk = b - Aqmr;
                    yk = epk - Hk*deltaXkm;
                    deltaXkp = (deltaXkm + Kk*yk);
                end
                
                % Update quaternion
                dalphak = deltaXkp(1:3,1);
                norm_dalphak_sq = dalphak(1)^2 + dalphak(2)^2 + dalphak(3)^2;
                dq = (1/sqrt(4+norm_dalphak_sq))*[dalphak' 2]';
                qkp = quatProd( dq, qkm );
                
                % Update biases
                deltaBeta = deltaXkp(4:6,1);
                betakp = betakm + deltaBeta;
                
                obj.dalpha = obj.dalpha + dalphak;
            end
            
            % Depolarize bias from Gyroscope
            omekhat = Gyroscope - betakp;
            
            %% Prediction (time update)
            % Quaternion integration
            qDot = quatDerivative( omekhat, qkp );
            
            qk = qkp + qDot * obj.SamplePeriod;
            qk = qk / norm(qk); % normalise quaternion
            
            % Covariance equation propagation
            dt = obj.SamplePeriod;
            Phi = [I3 -I3*dt ;
                   O3   I3  ];
            gamma = [-I3 O3 ;
                      O3 I3];
            Q = [(obj.Sigma_v^2*dt + 1/3*obj.Sigma_u^2*dt^3)*I3 (0.5*obj.Sigma_u^2*dt^2)*I3 ;
                         (0.5*obj.Sigma_u^2*dt^2)*I3            (obj.Sigma_u^2*dt)*I3  ];
            Pk = Phi*Pkp*Phi' + gamma*Q*gamma';
            
            %% Outputs
            obj.Quaternion = qk;
            obj.bias = betakp;
            obj.P = Pk;
        end   
        function obj = UpdateIMU(obj, Gyroscope, Accelerometer)
            % Constant parameters renamed for simplicity
            I3 = eye(3);
            I6 = eye(6);
            O3 = zeros(3);
            
            % Normalise accelerometer measurement
            if(norm(Accelerometer) == 0), return; end       % handle NaN
            b_acc = Accelerometer / norm(Accelerometer);    % normalise magnitude
            
            % Propagated value from previous step
            betakm = obj.bias;
            qkm = obj.Quaternion;
            Pkm = obj.P;
            deltaXkm = zeros(6,1);
            
            % Compute attitude matrix
            Akm = quatToAtt(qkm);
            
            %% Correction (measurement update)
            
            % Reference direction of Earth's gravitational field
            r_acc = [ 0  ;
                      0  ;
                      1 ];
            Aqmr = Akm * r_acc;
            b = b_acc;
            R = obj.Sigma_acc^2 * I3;
            
            % Sensitivity Matrix
            Aqmrx = [     0   -Aqmr(3)  Aqmr(2) ;
                      Aqmr(3)    0     -Aqmr(1) ;
                     -Aqmr(2)  Aqmr(1)    0    ];
            Hk = [Aqmrx O3];
            
            % Gain
            Kk = (Pkm * Hk')/(Hk * Pkm * Hk' + R);
            
            % Update Covariance
            Pkp = (I6 - Kk * Hk) * Pkm * (I6 - Kk * Hk)' + Kk * R * Kk';
            
            % Update state
            epk = b - Aqmr;
            yk = epk - Hk * deltaXkm;
            deltaXkp = (deltaXkm + Kk * yk);
            
            % Update quaternion
            dalphak = deltaXkp(1:3,1);
            norm_dalphak_sq = dalphak(1)^2 + dalphak(2)^2 + dalphak(3)^2;
            dq = (1/sqrt(4+norm_dalphak_sq))*[dalphak' 2]';
            qkp = quatProd( dq, qkm );
            
            % Update biases
            deltaBeta = deltaXkp(4:6,1);
            betakp = betakm + deltaBeta;
            
            obj.dalpha = obj.dalpha + dalphak;
            
            % Depolarize bias from Gyroscope
            omekhat = Gyroscope - betakp;
            
            %% Prediction (time update)
            % Quaternion integration
            qDot = quatDerivative( omekhat, qkp );
            
            qk = qkp + qDot * obj.SamplePeriod;
            qk = qk / norm(qk); % normalise quaternion
            
            % Covariance equation propagation
            dt = obj.SamplePeriod;
            Phi = [I3 -I3*dt ;
                   O3   I3  ];
            gamma = [-I3 O3 ;
                      O3 I3];
            Q = [(obj.Sigma_v^2*dt + 1/3*obj.Sigma_u^2*dt^3)*I3 (0.5*obj.Sigma_u^2*dt^2)*I3 ;
                             (0.5*obj.Sigma_u^2*dt^2)*I3            (obj.Sigma_u^2*dt)*I3  ];
            Pk = Phi*Pkp*Phi' + gamma*Q*gamma';
            
            %% Outputs
            obj.Quaternion = qk;
            obj.bias = betakp;
            obj.P = Pk;
        end
    end    
end