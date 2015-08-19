function  calibrateGyro(inFile, outFile, axis, target, samplePeriod, gain)

    %--------------------------------------------------------------------------  
    % Import data

    M = dlmread (inFile, ',', 0, 0); 
    sensMeas = M(:,axis);

    %--------------------------------------------------------------------------    
    % Find gains and biases

    bias = sensMeas(1) + ([1:numel(sensMeas)]'/numel(sensMeas)) * (sensMeas(end) - sensMeas(1));
    sensMeas = sensMeas - bias;

    optionsOpt = optimset('LargeScale', 'off', 'Display', 'off', 'TolX', 1E-21, 'TolFun', 1E-21, 'HessUpdate', 'bfgs', 'MaxIter', 128);  
    optVal = [gain];                            % vector of initial guess for optimal value
    optValScaler = 1 ./ optVal;                 % individual scalers unit optimal values
    optVal = optVal .* optValScaler;            % initial guess for optimal values = unity
    optVal = fminunc('objFunGyro', optVal, optionsOpt, optValScaler, sensMeas, target, samplePeriod);
    optVal = optVal ./ optValScaler;            % rescale optimal values to original units
    gain = optVal(1);

    %--------------------------------------------------------------------------    
    % Plot calibrated data

    sensMeas = gain*sensMeas;
    angle = zeros(length(sensMeas), 1);
    for t = 2:numel(sensMeas)
        angle(t) = angle(t-1) + sensMeas(t) * samplePeriod;
    end

    figure('Position',[10,40,1024,600]);
    hold on;    
    plot(1:length(sensMeas), sensMeas + gain*(bias-bias(1)), 'b');
    plot(1:length(sensMeas), angle, 'r');    
    plot(1:length(sensMeas), gain*(bias-bias(1)), 'k:');     
    plot([1 length(sensMeas)], [target target], 'k--');     
    legend('Angular velocity', 'Angular position', 'Bias');
    title('Gyroscope calibration');
    ylabel('Angular units');
        xlabel('Sample');    
    drawnow;

    %--------------------------------------------------------------------------  
    % Write gains and biases to CSV file

    fid = fopen(outFile, 'w');
    fprintf(fid, '%f\n', gain*mean(bias));
    fprintf(fid, '%f\n', gain);
    fclose(fid);
    
end

