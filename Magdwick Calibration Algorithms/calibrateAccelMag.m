function calibrateAccelMag(inFile, outFile, accelElseMag, feildMagnitude, bias, gain)

    %--------------------------------------------------------------------------  
    % Import data

    M = dlmread (inFile, ',', 0, 0); 
    if (accelElseMag)
        sensMeas = M(:,4:6); 
    else
        sensMeas = M(:,7:9);
    end

    %--------------------------------------------------------------------------    
    % Find gains and biases

    optionsOpt = optimset('LargeScale', 'off', 'Display', 'off', 'TolX', 1E-21, 'TolFun', 1E-21, 'HessUpdate', 'bfgs', 'MaxIter', 128);  
    optVal = [ones(1,3)*bias ones(1,3)*gain];  	% vector of initial guess for optimal value
    optValScaler = 1 ./ optVal;                 % individual scalers unit optimal values
    optVal = optVal .* optValScaler;            % initial guess for optimal values = unity
    optVal = fminunc('objFunAccelMag', optVal, optionsOpt, optValScaler, sensMeas, feildMagnitude);
    optVal = optVal ./ optValScaler;            % rescale optimal values to original units
    bias = optVal(1:3);
    gain = optVal(4:6);

    %--------------------------------------------------------------------------    
    % Plot calibrated data

    figure('Position',[10,40,1024,600]);
    subplot(3,1,1:2)
        hold on;    
        sensMeas(:,1) = gain(1) * sensMeas(:,1) - bias(1);
        sensMeas(:,2) = gain(2) * sensMeas(:,2) - bias(2);
        sensMeas(:,3) = gain(3) * sensMeas(:,3) - bias(3);
        plot(1:length(sensMeas), sensMeas(:,1), 'b');
        plot(1:length(sensMeas), sensMeas(:,2), 'r');
        plot(1:length(sensMeas), sensMeas(:,3), 'g');
        legend('X', 'Y', 'Z');
        title('Accelerometer/magnetometer calibration');
        ylabel('Sensor units');
    subplot(3,1,3)    
        hold on;
        plot(1:length(sensMeas), sqrt((sensMeas(:,1).^2) + (sensMeas(:,2).^2) + (sensMeas(:,3).^2)), 'Color', [0.6, 0.6, 0.6]);
        plot([0 length(sensMeas)], [feildMagnitude feildMagnitude], 'k:');
        legend('Feild magnitude', 'Mean feild magnitude');
        ylabel('Sensor units');
        xlabel('Sample');
    drawnow;
    
    %--------------------------------------------------------------------------  
    % Write gains and biases to CSV file

    fid = fopen(outFile, 'w');
    fprintf(fid, '%f,%f,%f\n', bias(1), bias(2), bias(3));
    fprintf(fid, '%f,%f,%f\n', gain(1), gain(2), gain(3));
    fclose(fid);
    
end

