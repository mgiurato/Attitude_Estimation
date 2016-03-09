classdef KalmanAHRS < handle
    % KALMAN_AHRS
    %   Date          Author
    %   2016/02/25    Mattia Giurato
    
    %% Public properties
    properties (Access = public)
        SamplePeriod = 0.01;
        sigma_A = 1;
        sigma_M = 1;
        sigma_U = 1;
        sigma_V = 1;
        Quaternion = [0 0 0 1]';
        omehat = zeros(3,1);
        bias = zeros(3,1);
        P = eye(6);
        deltaX = zeros(6,1);
        e = zeros(3,1);
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
                elseif  strcmp(varargin{i}, 'P'), obj.P = varargin{i+1};
                else error('Invalid argument');
                end
            end;
        end
        function obj = UpdateIMU(obj, Gyroscope, Accelerometer, Magnetometer)
            
            % Constant parameters renamed for simplicity
            dt = obj.SamplePeriod;
            sigma_acc = obj.sigma_A;
            sigma_mag = obj.sigma_M;
            sigma_u = obj.sigma_U;
            sigma_v = obj.sigma_V;
            
            % Normalise accelerometer measurement
            if(norm(Accelerometer) == 0), return; end % handle NaN
            b_acc = Accelerometer / norm(Accelerometer); % normalise magnitude
            
            % Normalise magnetometer measurement
            if(norm(Magnetometer) == 0), return; end % handle NaN
            b_mag = Magnetometer / norm(Magnetometer); % normalise magnitude
                    
            %% Propagated value from previous step
            betakm = obj.bias;
            qkm = obj.Quaternion;
            Pkm = obj.P;
            deltaXkm = zeros(6,1);
            
            %% Compute
            % Compute attitude matrix
            ro = [qkm(1) ;
                  qkm(2) ;
                  qkm(3)];
            rox = [   0   -ro(3)  ro(2) ;
                     ro(3)  0    -ro(1) ;
                    -ro(2) ro(1)   0   ];
            q_4 = qkm(4);
            Xi = [q_4*eye(3) + rox ;
                         -ro'     ];
            Psi = [q_4*eye(3) - rox ;
                         -ro'      ];
            Aqkm = Xi'*Psi;
            
            %% Accelerometer and Magnetometer correction     
%             for i = 1:1:2                
%                 if i == 1
%                     % Reference direction of Earth's gravitational field
%                     r_acc = [0 ;
%                              0 ;
%                              1];
%                     Aqmr = Aqkm*r_acc;
%                     b = b_acc;
%                     sigma = sigma_acc;
%                 elseif i == 2
%                     % Reference direction of Earth's magnetic feild
%                     h = Aqkm'*Magnetometer;
%                     r_mag = [norm([h(1) h(2)]) ;
%                                     0          ;
%                                    h(3)       ];
%                     Aqmr = Aqkm*r_mag;
%                     b = b_mag;
%                     sigma = sigma_mag;
%                 end
%                 
%                 R = sigma^2*eye(3);
%                 
%                 % Sensitivity Matrix
%                 Aqmrx = [      0   -Aqmr(3)  Aqmr(2) ;
%                            Aqmr(3)    0     -Aqmr(1) ;
%                           -Aqmr(2)  Aqmr(1)    0    ];
%                 Hk = [Aqmrx zeros(3)];
%                 
%                 % Gain
%                 Kk = (Pkm*Hk')/(Hk*Pkm*Hk' + R);
%                 
%                 % Update Covariance
%                 Pkp = (eye(6) - Kk*Hk)*Pkm*(eye(6) - Kk*Hk)' + Kk*R*Kk';
%                 
%                 % Update state
%                 epk = b - Aqmr; %residual
%                 deltaXkp = deltaXkm + Kk*(epk - Hk*deltaXkm);
%                 
%                 Pkm = Pkp;
%                 deltaXkm = deltaXkp;
%             end
            %% Accelerometer correction
            % Reference direction of Earth's gravitational field
            r_acc = [0 ;
                     0 ;
                     1];
            Aqmr = Aqkm*r_acc;
            b = b_acc;
            
            R = sigma_acc^2*eye(3);
            
            % Sensitivity Matrix
            Aqmrx = [      0   -Aqmr(3)  Aqmr(2) ;
                       Aqmr(3)    0     -Aqmr(1) ;
                      -Aqmr(2)  Aqmr(1)    0    ];
            Hk = [Aqmrx zeros(3)];
            
            % Gain
            Kk = (Pkm*Hk')/(Hk*Pkm*Hk' + R);
            
            % Update Covariance
            Pkp = (eye(6) - Kk*Hk)*Pkm*(eye(6) - Kk*Hk)' + Kk*R*Kk';
            
            % Update state
            epk = b - Aqmr; %residual
            yk = epk - Hk*deltaXkm;
            deltaXkp = deltaXkm + Kk*yk;
            
            % Update quaternion
            dalpha = deltaXkp(1:3,1);
            qkp = qkm + .5*Xi*dalpha;
            
            % Update biases            
            deltaBeta = deltaXkp(4:6,1);
            betakp = betakm + deltaBeta;
            
            %% Propagate
            % Quaternion propagation
            omekhat = Gyroscope - betakp;
            Psik = (sin(.5*norm(omekhat)*dt)/norm(omekhat))*omekhat;
            Psikx = [      0   -Psik(3)  Psik(2) ;
                       Psik(3)    0     -Psik(1) ;
                      -Psik(2)  Psik(1)    0    ];
            Omega = [cos(.5*norm(omekhat)*dt)*eye(3)- Psikx            Psik          ;
                                   -Psik'                   cos(.5*norm(omekhat)*dt)];
            qk = Omega*qkp;
            % Covariance equation propagation
            omekhatx = [     0      -omekhat(3)  omekhat(2) ;
                         omekhat(3)     0       -omekhat(1) ;
                        -omekhat(2)  omekhat(1)      0     ];
            Phi1 = eye(3) - omekhatx*sin(norm(omekhat)*dt)/norm(omekhat) + omekhatx*omekhatx*(1 - cos(norm(omekhat)*dt))/(norm(omekhat)^2);
            Phi2 = omekhatx*(1 - cos(norm(omekhat)*dt))/(norm(omekhat)^2) - eye(3)*dt - omekhatx*omekhatx*(norm(omekhat)*dt - sin(norm(omekhat)*dt))/(norm(omekhat)^3);
            Phi = [  Phi1    Phi2  ;
                   zeros(3) eye(3)];
            gamma = [-eye(3) zeros(3) ;
                     zeros(3) eye(3) ];
            Q = [(sigma_v^2*dt + 1/3*sigma_u^2*dt^3)*eye(3) (.5*sigma_u^2*dt^2)*eye(3) ;
                         (.5*sigma_u^2*dt^2)*eye(3)            (sigma_u^2*dt)*eye(3)  ];
            Pk = Phi*Pkp*Phi' + gamma*Q*gamma';
            
                     
            %% Outputs            
            obj.Quaternion = qk / norm(qk); % normalise quaternion
            obj.omehat = omekhat;
            obj.bias = betakp;
            obj.P = Pk;
            obj.deltaX = deltaXkp;           
            obj.e = yk;
        end
    end
end