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
                elseif  strcmp(varargin{i}, 'Quaternion'), obj.Quaternion = varargin{i+1};
                elseif  strcmp(varargin{i}, 'omehat'), obj.omehat = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Bias'), obj.bias = varargin{i+1};
                elseif  strcmp(varargin{i}, 'P'), obj.P = varargin{i+1};
                elseif  strcmp(varargin{i}, 'deltaX'), obj.deltaX = varargin{i+1};
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
            b1 = Accelerometer / norm(Accelerometer); % normalise magnitude
            
            % Normalise magnetometer measurement
            if(norm(Magnetometer) == 0), return; end % handle NaN
            b2 = Magnetometer / norm(Magnetometer); % normalise magnitude
            
            % Previous values
            deltaXk = obj.deltaX;
            
            %% Propagate
            % Quaternion propagation
            betakm = obj.bias;
            omekhat = Gyroscope - betakm;
            qkm = obj.Quaternion;
            Ome = [     0       omekhat(3) -omekhat(2) omekhat(1) ;
                   -omekhat(3)      0       omekhat(1) omekhat(2) ;
                    omekhat(2) -omekhat(1)      0      omekhat(3) ;
                   -omekhat(1) -omekhat(2) -omekhat(3)     0     ];
            qkp = (eye(4) + .5*Ome*dt)*qkm;
            
            % Covariance equation propagation
            Pkm = obj.P;
            omekhatx = [     0      -omekhat(3)  omekhat(2) ;
                         omekhat(3)     0       -omekhat(1) ;
                        -omekhat(2)  omekhat(1)      0     ];
%             Phi1 = eye(3) - omekhatx*sin(norm(omekhat)*dt)/norm(omekhat) + omekhatx*omekhatx*(1 - cos(norm(omekhat)*dt))/(norm(omekhat)^2);
%             Phi2 = omekhatx*(1 - cos(norm(omekhat)*dt))/(norm(omekhat)^2) - eye(3)*dt - omekhatx*omekhatx*(norm(omekhat)*dt - sin(norm(omekhat)*dt))/(norm(omekhat)^3);
%             Phi = [  Phi1    Phi2  ;
%                    zeros(3) eye(3)];
%             Gamma = [-eye(3) zeros(3) ;
%                      zeros(3) eye(3) ];
%             Q = [(sigma_v^2*dt + 1/3*sigma_u^2*dt^3)*eye(3) (.5*sigma_u^2*dt^2)*eye(3) ;
%                          (.5*sigma_u^2*dt^2)*eye(3)            (sigma_u^2*dt)*eye(3)  ];
%             Pkp = Phi*Pkm*Phi' + Gamma*Q*Gamma'; 
            F = dt * [-omekhatx  -eye(3) ;
                       zeros(3) zeros(3)];
            G = dt * [-eye(3) zeros(3) ;
                      zeros(3) eye(3) ];
            Q = [sigma_u^2*eye(3)        zeros(3)     ;
                        zeros(3)     sigma_v^2*eye(3)];
            Pkp = F*Pkm*F' + G*Q*G';
            
            %% Compute
            % Compute attitude matrix
%             ro = [qkp(1) ;
%                   qkp(2) ;
%                   qkp(3)];
%             rox = [   0   -ro(3)  ro(2) ;
%                      ro(3)  0    -ro(1) ;
%                     -ro(2) ro(1)   0   ];
%             q_4 = qkp(4);
%             Xi = [q_4*eye(3) + rox ;
%                          -ro'     ];
%             PSI = [q_4*eye(3) - rox ;
%                          -ro'      ];
%             Aqkm = Xi'*PSI;
            Aqkm = [qkp(1)^2-qkp(2)^2-qkp(3)^2+qkp(4)^2   2*(qkp(1)*qkp(2) + qkp(3)*qkp(4))    2*(qkp(1)*qkp(3) - qkp(2)*qkp(4))  ;
                     2*(qkp(1)*qkp(2) - qkp(3)*qkp(4))  -qkp(1)^2+qkp(2)^2-qkp(3)^2+qkp(4)^2   2*(qkp(2)*qkp(3) + qkp(1)*qkp(4))  ;
                     2*(qkp(1)*qkp(3) + qkp(2)*qkp(4))    2*(qkp(2)*qkp(3) - qkp(1)*qkp(4))  -qkp(1)^2-qkp(2)^2+qkp(3)^2+qkp(4)^2];
            
            %%      
            for i = 1:1:2                
                if i == 1
                    % Reference direction of Earth's gravitational field
                    r_acc = [0 ;
                             0 ;
                             1];
                    Aqmr = Aqkm*r_acc;
                    b = b1;
                    sigma = sigma_acc;
                elseif i == 2
                    % Reference direction of Earth's magnetic feild
                    h = Aqkm*Magnetometer;
                    r_mag = [norm([h(1) h(2)]) ;
                                    0          ;
                                   h(3)       ];
                    Aqmr = Aqkm*r_mag;
                    b = b2;
                    sigma = sigma_mag;
                end
                
                R = sigma^2*eye(3);
                
                % Sensitivity Matrix
                Aqmrx = [      0   -Aqmr(3)  Aqmr(2) ;
                           Aqmr(3)    0     -Aqmr(1) ;
                          -Aqmr(2)  Aqmr(1)    0    ];
                Hk = [Aqmrx zeros(3)];
                
                % Gain
                Kk = (Pkp*Hk')/(Hk*Pkp*Hk' + R);
                
                % Update state
                epk = b - Aqmr; %residual
                deltaXk = deltaXk + Kk*(epk - Hk*deltaXk);
                
                % Update Covariance
                Pkp = (eye(6) - Kk*Hk)*Pkp*(eye(6) - Kk*Hk)' + Kk*R*Kk';
            end
                  
            % Update quaternion
            dalpha = deltaXk(1:3,1);
            dqx =  [   1      -dalpha(1) -dalpha(2) -dalpha(3) ;
                    dalpha(1)     1      -dalpha(3)  dalpha(2) ;
                    dalpha(2)  dalpha(3)    1       -dalpha(1) ;
                    dalpha(3) -dalpha(2)  dalpha(1)     1     ];
            qtemp = dqx * [qkp(4) qkp(1) qkp(2) qkp(3)]';
            qhat = [qtemp(2) qtemp(3) qtemp(4) qtemp(1)]';
%             qhat = qkp + .5*Xi*dalpha;
            
            % Update biases            
            deltaBeta = deltaXk(4:6,1);
            betakp = betakm + deltaBeta;
            
            obj.Quaternion = qhat / norm(qhat); % normalise quaternion
            obj.omehat = omekhat;
            obj.bias = betakp;
            obj.P = Pkp;
            obj.deltaX = deltaXk;           
        end
    end
end