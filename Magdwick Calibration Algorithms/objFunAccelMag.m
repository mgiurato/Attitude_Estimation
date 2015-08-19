function SSE = objFunAccelMag(optVal, optValScaler, data, magnitude)
    optVal = optVal ./ optValScaler;	% rescale optimal values to original units
    bias = optVal(1:3);
    gain = optVal(4:6);
	error = magnitude - sqrt((gain(1) * data(:,1) - bias(1)).^2 +...
                             (gain(2) * data(:,2) - bias(2)).^2 +...
                             (gain(3) * data(:,3) - bias(3)).^2);
    SSE = error' * error;               % return the Sum of the Squares of the Errors
end
