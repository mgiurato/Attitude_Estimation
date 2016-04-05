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
        RPYkal = zeros(3,1);
        omehat = 0.00001*[1 1 1]';
        bias = 0.00001*[1 1 1]';
        P = (1e-5)*[1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 1 0 0 0; 0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1];
        dalpha = [0 0 0]';
        e = [0 0 0]';
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
            dalphaTot = obj.dalpha;
            
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
                        
            %% Accelerometer and Magnetometer correction  
            % Constant values
            I3 = [1 0 0; 0 1 0; 0 0 1];
            I6 = [1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 1 0 0 0; 0 0 0 1 0 0; 0 0 0 0 1 0; 0 0 0 0 0 1];
            O3 = [0 0 0; 0 0 0; 0 0 0];
            
            % Compute attitude matrix
            ro = [qkm(1) ;
                  qkm(2) ;
                  qkm(3)];
            q_4 = qkm(4);
            rox = [   0   -ro(3)  ro(2) ;
                     ro(3)  0    -ro(1) ;
                    -ro(2) ro(1)   0   ];
            % Paper-style
            %                 Xi = [q_4*I3 + rox ;
            %                              -ro'     ];
            %                 Psi = [q_4*I3 - rox ;
            %                              -ro'      ];
            %                 Aqkm = Xi'*Psi;
            % Canonical-style
            norm_ro_sq = ro(1)^2 + ro(2)^2 + ro(3)^2;
            Aqkm = (q_4^2 - norm_ro_sq)*I3 + 2*(ro*ro') - 2*q_4*rox;
            for i = 1:1:2
                if i == 1
                    % Reference direction of Earth's gravitational field
                    r_acc = [0 ;
                             0 ;
                             1];
                    Aqmr = Aqkm*r_acc;
                    b = b_acc;
                    R = sigma_acc^2*I3;
                
                    % Sensitivity Matrix
                    Aqmrx = [      0   -Aqmr(3)  Aqmr(2) ;
                               Aqmr(3)    0     -Aqmr(1) ;
                              -Aqmr(2)  Aqmr(1)    0    ];
                    Hk = [Aqmrx O3];
                    
                    % Gain
                    Kk = (Pkm*Hk')/(Hk*Pkm*Hk' + R);
%                     Kk = [ 1.9e-06   2.0e-03   2.3e-05 ;
%                           -1.7e-03  -1.3e-05   1.4e-05 ;
%                           -1.8e-04   1.0e-03   1.3e-06 ;
%                           -6.5e-07  -2.0e-04  -2.6e-06 ;
%                            1.4e-04  -8.3e-07  -1.1e-06 ;
%                           -3.2e-08  -5.3e-07  -4.3e-09];
%                     Kk = [-0.0000    0.0021    0.0000 ;
%                           -0.0018   -0.0000    0.0000 ;
%                            0.0003    0.0012    0.0000 ;
%                           -0.0000   -0.0002   -0.0000 ;
%                            0.0001   -0.0000   -0.0000 ;
%                           -0.0000   -0.0000   -0.0000];
                                                
                    % Update Covariance
                    Pkp = (I6 - Kk*Hk)*Pkm*(I6 - Kk*Hk)' + Kk*R*Kk';
                    
                    % Update state
                    epk = b - Aqmr; %residual
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
%                     Kk = [-7.8e-08  -7.9e-06   1.1e-07 ;
%                            1.9e-06   2.5e-06   5.4e-07 ;
%                           -3.6e-06  -1.8e-04  -5.2e-07 ;
%                           -7.1e-10   3.2e-07  -1.0e-09 ;
%                            1.5e-07   2.8e-08  -3.9e-08 ;
%                            1.6e-09   8.3e-08   2.4e-10];
%                     Kk =    1.0e-03 * [-0.0000   -0.0049    0.0000 ;
%                                         0.0018    0.0027    0.0005 ;
%                                        -0.0035   -0.1714   -0.0006 ;
%                                        -0.0000    0.0003   -0.0000 ;
%                                        -0.0001    0.0000   -0.0000 ;
%                                         0.0000    0.0001    0.0000];

                    % Update Covariance
                    Pkp = (I6 - Kk*Hk)*Pkm*(I6 - Kk*Hk)' + Kk*R*Kk';
                    
                    % Update state
                    epk = b - Aqmr; %residual
                    yk = epk - Hk*deltaXkm;
                    deltaXkp = (deltaXkm + Kk*yk);
                end
                
                % Update quaternion
                dalphak = deltaXkp(1:3,1);
                norm_dalphak_sq = dalphak(1)^2 + dalphak(2)^2 + dalphak(3)^2;
                % Paper-style
%                 qkp = qkm + .5*Xi*dalpha;
                % Canonical-style
                dq = (1/sqrt(4+norm_dalphak_sq))*[dalphak' 2]';
                qkp = [dq(4)*ro + q_4*dq(1:3,1)-cross(dq(1:3,1),ro) ;
                               dq(4)*q_4 - dot(dq(1:3,1),ro)       ];
                
                % Update biases
                deltaBeta = deltaXkp(4:6,1);
                betakp = betakm + deltaBeta;
                
                dalphaTot = dalphaTot + dalphak;
            end
                       
            %% Accelerometer correction
            
%             % Compute attitude matrix
%             ro = [qkm(1) ;
%                   qkm(2) ;
%                   qkm(3)];
%             q_4 = qkm(4);
%             rox = [   0   -ro(3)  ro(2) ;
%                      ro(3)  0    -ro(1) ;
%                     -ro(2) ro(1)   0   ];
%             % Paper-style
%             Xi = [q_4*I3 + rox ;
%                          -ro'     ];
% %             Psi = [q_4*I3 - rox ;
% %                          -ro'      ];
% %             Aqkm = Xi'*Psi;
%             % Canonical-style
%             Aqkm = (q_4^2 - norm(ro)^2)*I3 + 2*(ro*ro') - 2*q_4*rox;
%             
%             % Reference direction of Earth's gravitational field
%             r_acc = [0 ;
%                      0 ;
%                      1];
%             Aqmr = Aqkm*r_acc;
%             b = b_acc;
%             
%             R = sigma_acc^2*I3;
%             
%             % Sensitivity Matrix
%             Aqmrx = [      0   -Aqmr(3)  Aqmr(2) ;
%                        Aqmr(3)    0     -Aqmr(1) ;
%                       -Aqmr(2)  Aqmr(1)    0    ];
%             Hk = [Aqmrx O3];
%             
%             % Gain
%             Kk = (Pkm*Hk')/(Hk*Pkm*Hk' + R);
%             
%             % Update Covariance
%             Pkp = (I6 - Kk*Hk)*Pkm*(I6 - Kk*Hk)' + Kk*R*Kk';
%             
%             % Update state
%             epk = b - Aqmr; %residual
%             yk = epk - Hk*deltaXkm;
%             deltaXkp = deltaXkm + Kk*yk;
% 
%             % Update quaternion
%             dalphaTot = diag([1 1 0])*deltaXkp(1:3,1);
%             qkp = qkm + .5*Xi*dalphaTot;
%             
%             % Update biases            
%             deltaBeta = diag([1 1 0])*deltaXkp(4:6,1);
%             betakp = betakm + deltaBeta;

            %% Depolarize bias from Gyroscope 
            omekhat = Gyroscope - betakp;
            
            %% Propagate
            % Quaternion propagation
            % Paper-style
%             Psik = (sin(.5*norm(omekhat)*dt)/norm(omekhat))*omekhat;
%             Psikx = [      0   -Psik(3)  Psik(2) ;
%                        Psik(3)    0     -Psik(1) ;
%                       -Psik(2)  Psik(1)    0    ];
%             Omega = [cos(.5*norm(omekhat)*dt)*I3- Psikx            Psik          ;
%                                    -Psik'                   cos(.5*norm(omekhat)*dt)];
%             qk = Omega*qkp;
            % Canonical-style
            omex = [     0      -omekhat(3)  omekhat(2) ;
                     omekhat(3)      0      -omekhat(1) ;
                    -omekhat(2)  omekhat(1)      0     ];
            Omega = [  -omex   omekhat ;
                     -omekhat'     0  ];
            qk = (eye(4) + .5*Omega*dt)*qkp;
            qk = qk / norm(qk); % normalise quaternion
            
            % Covariance equation propagation
%             omekhatx = [     0      -omekhat(3)  omekhat(2) ;
%                          omekhat(3)     0       -omekhat(1) ;
%                         -omekhat(2)  omekhat(1)      0     ];
%             Phi1 = I3 - omekhatx*sin(norm(omekhat)*dt)/norm(omekhat) + omekhatx*omekhatx*(1 - cos(norm(omekhat)*dt))/(norm(omekhat)^2);
%             Phi2 = omekhatx*(1 - cos(norm(omekhat)*dt))/(norm(omekhat)^2) - I3*dt - omekhatx*omekhatx*(norm(omekhat)*dt - sin(norm(omekhat)*dt))/(norm(omekhat)^3);
            Phi1 = I3;
            Phi2 = -I3*dt;
            Phi = [Phi1 Phi2 ;
                    O3   I3 ];
            gamma = [-I3 O3 ;
                      O3 I3];
            Q = [(sigma_v^2*dt + 1/3*sigma_u^2*dt^3)*I3 (.5*sigma_u^2*dt^2)*I3 ;
                         (.5*sigma_u^2*dt^2)*I3            (sigma_u^2*dt)*I3  ];
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
            
            RPY = [Rr -Pp -Yy]';
                                 
            %% Outputs            
            obj.Quaternion = qk;
            obj.RPYkal = RPY;
            obj.omehat = omekhat;
            obj.bias = betakp;
            obj.P = Pk;
            obj.dalpha = dalphaTot;           
            obj.e = yk;
        end
    end
end