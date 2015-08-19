function error = objFunGyro(optVal, optValScaler, data, target, samplePeriod)
    optVal = optVal ./ optValScaler;                % rescale optimal values to original units
    gain = optVal(1);
    omega = gain * data;
    angle = 0;
    for t = 2:numel(data)
        angle = angle + omega(t) * samplePeriod;	% integrate angular velocity to find final angle
    end
    error = (angle - target)^2;                  	% error is squared difference between final angle and specified target
end
