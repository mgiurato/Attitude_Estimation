classdef KalmanAHRS < handle
    % KalmanAHRS
    %   Date          Author
    %   2016/02/25    Mattia Giurato
    
    %% Public properties
    properties (Access = public)
        SamplePeriod = 0.01;        % [s] Sample time
        sigma_A = 1;                % Sigma accelerometer
        sigma_M = 1;                % Sigma magnetometer
        sigma_U = 1;                % Sigma rate random walk
        sigma_V = 1;                % Sigma angle random walk
        Quaternion = [0 0 0 1]';    % Attitude initial condition (Quaternion)
        R_P_Y = [0 0 0]';           % Attitude initial condition (Euler)
        omehat = (1e-3)*eye(3,1);   % Angular rate initial condition
        bias = (1e-3)*eye(3,1);     % Angular rate bias initial condition
        P = (1e-5)*eye(6);          % Covariance matrix initial condition
        dalpha = [0 0 0]';          % Attitude estimation error initial condition
        y = [0 0 0]';
    end
    
    %% Public methods
    methods (Access = public)
        function obj = KalmanAHRS(varargin)
            for i = 1:2:nargin
                if  strcmp(varargin{i}, 'SamplePeriod'), obj.SamplePeriod = varargin{i+1};
                elseif  strcmp(varargin{i}, 'sigma_acc'), obj.sigma_A = varargin{i+1};
                elseif  strcmp(varargin{i}, 'sigma_mag'), obj.sigma_M = varargin{i+1};
                elseif  strcmp(varargin{i}, 'sigma_u'), obj.sigma_U = varargin{i+1};
                elseif  strcmp(varargin{i}, 'sigma_v'), obj.sigma_V = varargin{i+1};
                elseif  strcmp(varargin{i}, 'bias'), obj.bias = varargin{i+1};
                elseif  strcmp(varargin{i}, 'P'), obj.P = varargin{i+1};
                else error('Invalid argument');
                end
            end;
        end
        
        function obj = Update(obj, Gyroscope, Accelerometer, Magnetometer)
            % Constant parameters renamed for simplicity
            dt = obj.SamplePeriod;
            sigma_acc = obj.sigma_A;
            sigma_mag = obj.sigma_M;
            sigma_u = obj.sigma_U;
            sigma_v = obj.sigma_V;
            dalphaTot = obj.dalpha;
            I3 = eye(3);
            I6 = eye(6);
            O3 = zeros(3);
            
            % Normalise accelerometer measurement
            if(norm(Accelerometer) == 0), return; end       % handle NaN
            b_acc = Accelerometer / norm(Accelerometer);    % normalise magnitude
            
            % Normalise magnetometer measurement
            if(norm(Magnetometer) == 0), return; end        % handle NaN
            b_mag = Magnetometer / norm(Magnetometer);      % normalise magnitude
            
            %% Propagated value from previous step
            betakm = obj.bias;
            qkm = obj.Quaternion;
            Pkm = obj.P;
            deltaXkm = zeros(6,1);
            
            %% Accelerometer and Magnetometer correction
            % Compute attitude matrix
            ro = [qkm(1) ;
                  qkm(2) ;
                  qkm(3)];
            q_4 = qkm(4);
            rox = [  0   -ro(3)  ro(2) ;
                    ro(3)  0    -ro(1) ;
                   -ro(2) ro(1)   0   ];
            norm_ro_sq = ro(1)^2 + ro(2)^2 + ro(3)^2;
            Aqkm = (q_4^2 - norm_ro_sq)*I3 + 2*(ro*ro') - 2*q_4*rox;
            
            for i = 1:1:2
                if i == 1
                    % Reference direction of Earth's gravitational field
                    r_acc = [ 0 ;
                              0 ;
                             -1];
                    Aqmr = Aqkm*r_acc;
                    b = b_acc;
                    R = sigma_acc^2*I3;
                    
                    % Sensitivity Matrix
                    Aqmrx = [     0   -Aqmr(3)  Aqmr(2) ;
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
                    
                    Pkm = Pkp;
                    deltaXkm = deltaXkp;
                    
                elseif i == 2
                    % Reference direction of Earth's magnetic feild
                    h = Aqkm*Magnetometer;
                    norm_h = sqrt(h(1)^2 + h(2)^2);
                    r_mag = [norm_h ;
                               0    ;
                              h(3) ];
                    Aqmr = Aqkm*r_mag;
                    b = b_mag;
                    R = sigma_mag^2*I3;
                    
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
                qkp = [dq(4)*ro + q_4*dq(1:3,1) - cross(dq(1:3,1),ro) ;
                               dq(4)*q_4 - dot(dq(1:3,1),ro)         ];
                
                % Update biases
                deltaBeta = deltaXkp(4:6,1);
                betakp = betakm + deltaBeta;
                
                dalphaTot = dalphaTot + dalphak;
            end
            
            %% Depolarize bias from Gyroscope
            omekhat = Gyroscope - betakp;
            
            %% Propagate
            % Quaternion propagation
            omex = [     0      -omekhat(3)  omekhat(2) ;
                     omekhat(3)      0      -omekhat(1) ;
                    -omekhat(2)  omekhat(1)      0     ];
            Omega = [  -omex   omekhat ;
                     -omekhat'     0  ];
            qk = (eye(4) + 0.5*Omega*dt)*qkp;
            qk = qk / norm(qk); % normalise quaternion
            
            % Covariance equation propagation
            Phi = [I3 -I3*dt ;
                   O3   I3  ];
            gamma = [-I3 O3 ;
                      O3 I3];
            Q = [(sigma_v^2*dt + 1/3*sigma_u^2*dt^3)*I3 (0.5*sigma_u^2*dt^2)*I3 ;
                         (0.5*sigma_u^2*dt^2)*I3            (sigma_u^2*dt)*I3  ];
            Pk = Phi*Pkp*Phi' + gamma*Q*gamma';
            
            %% Convert Quaternion into RPY
            a1 = 2.*(qk(1).*qk(2) + qk(4).*qk(3));
            a2 = qk(4).^2 + qk(1).^2 - qk(2).^2 - qk(3).^2;
            b = -2.*(qk(1).*qk(3) - qk(4).*qk(2));
            c1 = 2.*(qk(2).*qk(3) + qk(4).*qk(1));
            c2 = qk(4).^2 - qk(1).^2 - qk(2).^2 + qk(3).^2;
            
            Yy = atan2(a1, a2);
            Pp = asin(b);
            Rr = atan2(c1, c2);
            
            RPY = [Rr Pp Yy]';
            
            %% Outputs
            obj.Quaternion = qk;
            obj.R_P_Y = RPY;
            obj.omehat = omekhat;
            obj.bias = betakp;
            obj.P = Pk;
            obj.dalpha = dalphaTot;
            obj.y = yk;
        end
    end
end