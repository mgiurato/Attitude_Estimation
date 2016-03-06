classdef MadgwickAHRS < handle
%MADGWICKAHRS Implementation of Madgwick's IMU and AHRS algorithms
%
%   For more information see:
%   http://www.x-io.co.uk/node/8#open_source_ahrs_and_imu_algorithms
%
%   Date          Author          Notes
%   28/09/2011    SOH Madgwick    Initial release

    %% Public properties
    properties (Access = public)
        SamplePeriod = 0.01;
        Quaternion = [1 0 0 0];     % output quaternion describing the Earth relative to the sensor
        Beta = 0.12;               	% algorithm gain
        GyrBias = zeros(1,3);
        Zeta = 0;
    end

    %% Public methods
    methods (Access = public)
        function obj = MadgwickAHRS(varargin)
            for i = 1:2:nargin
                if  strcmp(varargin{i}, 'SamplePeriod'), obj.SamplePeriod = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Quaternion'), obj.Quaternion = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Beta'), obj.Beta = varargin{i+1};
                elseif  strcmp(varargin{i}, 'GyroBias'), obj.GyrBias = varargin{i+1};
                elseif  strcmp(varargin{i}, 'Zeta'), obj.Zeta = varargin{i+1};
                else error('Invalid argument');
                end
            end;
        end
        function obj = Update(obj, Gyroscope, Accelerometer, Magnetometer)
            q = obj.Quaternion; % short name local variable for readability

            % Normalise accelerometer measurement
            if(norm(Accelerometer) == 0), return; end	% handle NaN
            Accelerometer = Accelerometer / norm(Accelerometer);	% normalise magnitude

            % Normalise magnetometer measurement
            if(norm(Magnetometer) == 0), return; end	% handle NaN
            Magnetometer = Magnetometer / norm(Magnetometer);	% normalise magnitude

            % Reference direction of Earth's magnetic feild
            h = quaternProd(q, quaternProd([0 Magnetometer], quaternConj(q)));
            b = [0 norm([h(2) h(3)]) 0 h(4)];

            % Gradient decent algorithm corrective step
            F = [2*(q(2)*q(4) - q(1)*q(3)) - Accelerometer(1)
                 2*(q(1)*q(2) + q(3)*q(4)) - Accelerometer(2)
                 2*(0.5 - q(2)^2 - q(3)^2) - Accelerometer(3)
                 2*b(2)*(0.5 - q(3)^2 - q(4)^2) + 2*b(4)*(q(2)*q(4) - q(1)*q(3)) - Magnetometer(1)
                 2*b(2)*(q(2)*q(3) - q(1)*q(4)) + 2*b(4)*(q(1)*q(2) + q(3)*q(4)) - Magnetometer(2)
                 2*b(2)*(q(1)*q(3) + q(2)*q(4)) + 2*b(4)*(0.5 - q(2)^2 - q(3)^2) - Magnetometer(3)];
            J = [       -2*q(3),                 	2*q(4),                  -2*q(1),                      2*q(2)
                         2*q(2),                 	2*q(1),                   2*q(4),                      2*q(3)
                           0,                      -4*q(2),                  -4*q(3),                        0
                      -2*b(4)*q(3),               2*b(4)*q(4),        -4*b(2)*q(3)-2*b(4)*q(1),  -4*b(2)*q(4)+2*b(4)*q(2)
                 -2*b(2)*q(4)+2*b(4)*q(2),	2*b(2)*q(3)+2*b(4)*q(1),   2*b(2)*q(2)+2*b(4)*q(4),  -2*b(2)*q(1)+2*b(4)*q(3)
                       2*b(2)*q(3),         2*b(2)*q(4)-4*b(4)*q(2),   2*b(2)*q(1)-4*b(4)*q(3),         2*b(2)*q(2)      ];
            step = (J'*F);
            step = step / norm(step);	% normalise step magnitude
            
            % Compute angular estimated direction of the gyroscope error
            g_err = 2*quaternProd(q, step');
            
%             g_err_x = 2*q(1) * step(2) - 2*q(2) * step(1) - 2*q(3) * step(4) + 2*q(4) * step(3);
%             g_err_y = 2*q(1) * step(3) + 2*q(2) * step(4) - 2*q(3) * step(1) - 2*q(4) * step(2);
%             g_err_z = 2*q(1) * step(4) - 2*q(2) * step(3) + 2*q(3) * step(2) - 2*q(4) * step(1);

            % Compute and remove the gyroscope baises
            obj.GyrBias(1) = obj.GyrBias(1) + g_err(1) * obj.Zeta * obj.SamplePeriod;
            obj.GyrBias(2) = obj.GyrBias(2) + g_err(2) * obj.Zeta * obj.SamplePeriod;
            obj.GyrBias(3) = obj.GyrBias(3) + g_err(3) * obj.Zeta * obj.SamplePeriod;
            Gyroscope = Gyroscope - obj.GyrBias;

            % Compute rate of change of quaternion
            qDot = 0.5 * quaternProd(q, [0 Gyroscope(1) Gyroscope(2) Gyroscope(3)]) - obj.Beta * step';

            % Integrate to yield quaternion
            q = q + qDot * obj.SamplePeriod;
            obj.Quaternion = q / norm(q); % normalise quaternion
        end
        function obj = UpdateIMU(obj, Gyroscope, Accelerometer)
            q = obj.Quaternion; % short name local variable for readability

            % Normalise accelerometer measurement
            if(norm(Accelerometer) == 0), return; end	% handle NaN
            Accelerometer = Accelerometer / norm(Accelerometer);	% normalise magnitude

            % Gradient decent algorithm corrective step
            F = [2*(q(2)*q(4) - q(1)*q(3)) - Accelerometer(1)
                 2*(q(1)*q(2) + q(3)*q(4)) - Accelerometer(2)
                 2*(0.5 - q(2)^2 - q(3)^2) - Accelerometer(3)];
            J = [-2*q(3),	2*q(4),  -2*q(1),  2*q(2)
                  2*q(2),   2*q(1),   2*q(4),  2*q(3)
                    0,     -4*q(2),  -4*q(3),	 0   ];
            step = (J'*F);
            step = step / norm(step);	% normalise step magnitude

            % Compute rate of change of quaternion
            qDot = 0.5 * quaternProd(q, [0 Gyroscope(1) Gyroscope(2) Gyroscope(3)]) - obj.Beta * step';

            % Integrate to yield quaternion
            q = q + qDot * obj.SamplePeriod;
            obj.Quaternion = q / norm(q); % normalise quaternion
        end
    end
end