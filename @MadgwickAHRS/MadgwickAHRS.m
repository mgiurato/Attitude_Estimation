classdef MadgwickAHRS < handle
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Madgwick's AHRS                %
    % Author: M.Giurato              %
    % Date: 09/09/2016               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    %% Public properties
    properties (Access = public)
        SamplePeriod = 1/100;       % [s] Sample time
        Quaternion = [0 0 0 1]';    % output quaternion describing the attitude of the body referred to the inertial system
        bias = [0 0 0]';            % estimated bias
        Beta = 1;               	% algorithm gain
        Zeta = 1;               	% algorithm gain
    end
    
    %% Public methods
    methods (Access = public)
        function obj = MadgwickAHRS(varargin)
            for i = 1:2:nargin
                if  strcmp(varargin{i}, 'SamplePeriod'), obj.SamplePeriod = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Quaternion'), obj.Quaternion = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Beta'), obj.Beta = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Zeta'), obj.Zeta = varargin{i+1};
                else error('Invalid argument');
                end
            end;
        end
        function obj = Update(obj, Gyroscope, Accelerometer, Magnetometer)
            q = obj.Quaternion; % short name local variable for readability
            
            % Normalise accelerometer measurement
            if(norm(Accelerometer) == 0), return; end               % handle NaN
            Accelerometer = Accelerometer / norm(Accelerometer);	% normalise magnitude
            
            % Normalise magnetometer measurement
            if(norm(Magnetometer) == 0), return; end                % handle NaN
            Magnetometer = Magnetometer / norm(Magnetometer);       % normalise magnitude
            
            % Compute attitude matrix
            A = quatToAtt(q);
            
            % Reference direction of Earth's gravitational field
            r_acc = [ 0  ;
                      0  ;
                      1 ];
            
            % Reference direction of Earth's magnetic feild
            h = A' * Magnetometer;
            b = [sqrt(h(1)^2 + h(2)^2) ;
                          0            ;
                         h(3)         ];
            
            % Estimated direction of gravity and magnetic field
            v_acc = A * r_acc;
            v_mag = A * b;
            
            % Gradient decent algorithm corrective step
            F = [v_acc - Accelerometer ;
                 v_mag - Magnetometer ];
            J = [                  2*q(3),                  -2*q(4),	               2*q(1),                  -2*q(2) ;
                                   2*q(4),                   2*q(3),	               2*q(2),                   2*q(1) ;
                                  -4*q(1),                  -4*q(2),                        0,                        0 ;
                              2*b(3)*q(3), -4*b(1)*q(2)-2*b(3)*q(4), -4*b(1)*q(3)+2*b(3)*q(1),             -2*b(3)*q(2) ;
                  2*b(1)*q(2)+2*b(3)*q(4),  2*b(1)*q(1)+2*b(3)*q(3), -2*b(1)*q(4)+2*b(3)*q(2), -2*b(1)*q(3)+2*b(3)*q(1) ;
                  2*b(1)*q(3)-4*b(3)*q(1),  2*b(1)*q(4)-4*b(3)*q(2),              2*b(1)*q(1),              2*b(1)*q(2)];
            step = (J'*F);
            step = step / norm(step);	% normalise step magnitude
            
            % Drift estimation
            ome_mes = 2*quatProd( q, step );
            
            % Bias estimation and gyroscope depolarization
            if(obj.Zeta > 0)
                obj.bias = obj.bias + ome_mes(1:3) * obj.SamplePeriod;
            else
                obj.bias = [0 0 0]';
            end
            Gyroscope = Gyroscope - obj.Zeta * obj.bias;
            
            % Compute rate of change of quaternion
            qDot = quatDerivative( Gyroscope, q ) - obj.Beta * step;
            
            % Integrate to yield quaternion
            q = q + qDot * obj.SamplePeriod;
            obj.Quaternion = q / norm(q); % normalise quaternion
        end
        function obj = UpdateIMU(obj, Gyroscope, Accelerometer)
            q = obj.Quaternion; % short name local variable for readability
            
            % Normalise accelerometer measurement
            if(norm(Accelerometer) == 0), return; end	% handle NaN
            Accelerometer = Accelerometer / norm(Accelerometer);	% normalise magnitude
            
            % Compute attitude matrix
            A = quatToAtt(q);
            
            % Reference direction of Earth's gravitational field
            r_acc = [ 0  ;
                      0  ;
                      1 ];
            
            % Estimated direction of gravity field
            v_acc = A * r_acc;
            
            % Gradient decent algorithm corrective step
            F = v_acc - Accelerometer;
            J = [ 2*q(3), -2*q(4),	2*q(1), -2*q(2) ;
                  2*q(4),  2*q(3),	2*q(2),  2*q(1) ;
                 -4*q(1), -4*q(2),       0,      0 ];
            step = J' * F;
            step = step / norm(step);	% normalise step magnitude
            
            % Drift estimation
            ome_mes = 2*quatProd( q, step );
            
            % Bias estimation and gyroscope depolarization
            if(obj.Zeta > 0)
                obj.bias = obj.bias + ome_mes(1:3) * obj.SamplePeriod;
            else
                obj.bias = [0 0 0]';
            end
            Gyroscope = Gyroscope - obj.Zeta * obj.bias;
            
            % Compute rate of change of quaternion
            qDot = quatDerivative( Gyroscope, q ) - obj.Beta * step;
            
            % Integrate to yield quaternion
            q = q + qDot * obj.SamplePeriod;
            obj.Quaternion = q / norm(q); % normalise quaternion
        end
    end
end