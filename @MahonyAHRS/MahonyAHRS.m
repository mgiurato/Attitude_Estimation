classdef MahonyAHRS < handle
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Mahony's AHRS                  %
    % Author: M.Giurato              %
    % Date: 08/09/2016               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Public properties
    properties (Access = public)
        SamplePeriod = 1/100;       % [s] Sample time
        Quaternion = [0 0 0 1]';    % output quaternion describing the attitude of the body referred to the inertial system
        Euler = [0 0 0]';           % estimated euler angles
        bias = [0 0 0]';            % estimated bias
        Kp = 1;                     % algorithm proportional gain
        Ki = 0;                     % algorithm integral gain
        Kacc = 2;                   % accelerometer weight
        Kmag = 2;                   % magnetometer weight
    end
    
    %% Public methods
    methods (Access = public)
        function obj = MahonyAHRS(varargin)
            for i = 1:2:nargin
                if  strcmp(varargin{i}, 'SamplePeriod'), obj.SamplePeriod = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Quaternion'), obj.Quaternion = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Kp'), obj.Kp = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Ki'), obj.Ki = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Kacc'), obj.Kacc = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Kmag'), obj.Kmag = varargin{i+1};
                else error('Invalid argument');
                end
            end;
        end
        function obj = Update(obj, Gyroscope, Accelerometer, Magnetometer)
            
            % Values from previous step
            qkm = obj.Quaternion;
            
            % Normalise accelerometer measurement
            if(norm(Accelerometer) == 0), return; end   % handle NaN
            v_acc = Accelerometer / norm(Accelerometer);    % normalise magnitude
            
            % Normalise magnetometer measurement
            if(norm(Magnetometer) == 0), return; end    % handle NaN
            v_mag = Magnetometer / norm(Magnetometer);   % normalise magnitude
            
            % Compute attitude matrix
            Akm = quatToAtt(qkm);
            
            % Reference direction of Earth's gravitational field
            r_acc = [ 0  ;
                      0  ;
                      1 ];
            
            % Reference direction of Earth's magnetic feild
            h = Akm' * v_mag;
            r_mag = [sqrt(h(1)^2 + h(2)^2) ;
                              0            ;
                             h(3)         ];
            
            % Estimated direction of gravity and magnetic field
            v_acc_hat = Akm * r_acc;
            v_mag_hat = Akm * r_mag;
            
            % Drift estimation
            acc_corr = obj.Kacc/2 * (v_acc*v_acc_hat' - v_acc_hat*v_acc');
            mag_corr = obj.Kmag/2 * (v_mag*v_mag_hat' - v_mag_hat*v_mag');
            ome_mes_x = (acc_corr + mag_corr);
            ome_mes = - [ome_mes_x(3,2) ;
                         ome_mes_x(1,3) ;
                         ome_mes_x(2,1)];
            
            % Bias estimation and gyroscope depolarization
            if(obj.Ki > 0)
                obj.bias = obj.bias + obj.Ki * ome_mes * obj.SamplePeriod;
            else
                obj.bias = [0 0 0]';
            end
            omek_hat = Gyroscope + obj.bias + obj.Kp * ome_mes;
            
            % Quaternion integration
            qDot = quatDerivative( omek_hat, qkm );
            
            qk = qkm + qDot * obj.SamplePeriod;
            obj.Quaternion = qk / norm(qk); % normalise quaternion
        end
        function obj = UpdateIMU(obj, Gyroscope, Accelerometer)
            % Values from previous step
            qkm = obj.Quaternion;
            
            % Normalise accelerometer measurement
            if(norm(Accelerometer) == 0), return; end   % handle NaN
            v_acc = Accelerometer / norm(Accelerometer);    % normalise magnitude
            
            % Compute attitude matrix
            Akm = quatToAtt(qkm);
            
            % Reference direction of Earth's gravitational field
            r_acc = [ 0  ;
                      0  ;
                      1 ];
            
            % Estimated direction of gravity field
            v_acc_hat = Akm * r_acc;
            
            % Drift estimation
            acc_corr = obj.Kacc/2 * (v_acc*v_acc_hat' - v_acc_hat*v_acc');
            ome_mes_x = acc_corr;
            ome_mes = - [ome_mes_x(3,2) ;
                         ome_mes_x(1,3) ;
                         ome_mes_x(2,1)];
            
            % Bias estimation and gyroscope depolarization
            if(obj.Ki > 0)
                obj.bias = obj.bias + obj.Ki * ome_mes * obj.SamplePeriod;
            else
                obj.bias = [0 0 0]';
            end
            omek_hat = Gyroscope + obj.bias + obj.Kp * ome_mes;
            
            % Quaternion integration
            qDot = quatDerivative( omek_hat, qkm );
            
            qk = qkm + qDot * obj.SamplePeriod;
            obj.Quaternion = qk / norm(qk); % normalise quaternion
        end
    end
end