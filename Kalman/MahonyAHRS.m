classdef MahonyAHRS < handle
    % Mahony_AHRS
    %   Date          Author
    %   2016/04/09    Mattia Giurato
    
    %% Public properties
    properties (Access = public)
        SamplePeriod = 0.01;
        K_A = 0;
        K_M = 0;
        K_P = 0;
        K_I = 0;
        Quaternion = [0 0 0 1]';
        R_P_Y = [0 0 0]';
        omehat = [0 0 0]';
        bias = [0 0 0]';
    end
    
    %% Public methods
    methods (Access = public)
        function obj = MahonyAHRS(varargin)
            for i = 1:2:nargin
                if  strcmp(varargin{i}, 'SamplePeriod'), obj.SamplePeriod = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Kacc'), obj.K_A = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Kmag'), obj.K_M = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Kp'), obj.K_P = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Ki'), obj.K_I = varargin{i+1};
                elseif  strcmp(varargin{i}, 'bias'), obj.bias = varargin{i+1};
                else error('Invalid argument');
                end
            end;
        end
        function obj = Update(obj, Gyroscope, Accelerometer, Magnetometer)
            % Constant parameters renamed for simplicity
            dt = obj.SamplePeriod;
            Kacc = obj.K_A;
            Kmag = obj.K_M;
            Kp = obj.K_P;
            Ki = obj.K_I;
            I3 = [1 0 0; 0 1 0; 0 0 1];
            
            % Normalise accelerometer measurement
            if(norm(Accelerometer) == 0), return; end % handle NaN
            v_acc = Accelerometer / norm(Accelerometer); % normalise magnitude
            
            % Normalise magnetometer measurement
            if(norm(Magnetometer) == 0), return; end % handle NaN
            v_mag = Magnetometer / norm(Magnetometer); % normalise magnitude
            
            %% Values from previous step
            betakm = obj.bias;
            qkm = obj.Quaternion;
            
            %% Compute attitude matrix
            ro = [qkm(1) ;
                  qkm(2) ;
                  qkm(3)];
            q_4 = qkm(4);
            rox = [   0   -ro(3)  ro(2) ;
                     ro(3)  0    -ro(1) ;
                    -ro(2) ro(1)   0   ];
            norm_ro_sq = ro(1)^2 + ro(2)^2 + ro(3)^2;
            Aqkm = (q_4^2 - norm_ro_sq)*I3 + 2*(ro*ro') - 2*q_4*rox;
            
            %% Accelerometer and Magnetometer corrections
            % Reference direction of Earth's gravitational field
            r_acc = [0 ;
                     0 ;
                     1];
            v_acc_hat = Aqkm*r_acc;
            
            % Reference direction of Earth's magnetic feild
            h = Aqkm*Magnetometer;
            norm_h = sqrt(h(1)^2 + h(2)^2);
            r_mag = [norm_h ;
                       0    ;
                      h(3) ];
            v_mag_hat = Aqkm*r_mag;
            
            % Correction factor
            acc_corr = Kacc/2*(v_acc*v_acc_hat' - v_acc_hat*v_acc');
            mag_corr = Kmag/2*(v_mag*v_mag_hat' - v_mag_hat*v_mag');
            ome_mes_x = -(acc_corr + mag_corr);
            ome_mes = [ome_mes_x(3,2) ;
                       ome_mes_x(1,3) ;
                       ome_mes_x(2,1)];
            
            %% Depolarize bias from Gyroscope
            betak = betakm - Ki*ome_mes*dt;
            omekhat = Gyroscope - betak;
            
            %% Quaternion integration
            ome = omekhat + Kp*ome_mes;
            omex = [   0    -ome(3)  ome(2) ;
                     ome(3)    0    -ome(1) ;
                    -ome(2)  ome(1)    0   ];
            Omega = [-omex ome ;
                     -ome'  0 ];
            qk = (eye(4) + .5*Omega*dt)*qkm;
            qk = qk / norm(qk); % normalise quaternion
            
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
            obj.R_P_Y = RPY;
            obj.omehat = omekhat;
            obj.bias = betak;
            
        end
    end
end