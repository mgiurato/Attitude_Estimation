function q = PRV2elem(r)

% PRV2elem(R)
%	
%	Q = PRV2elem(R) translates a prinicpal rotation vector R
%	into the corresponding principal rotation element set Q.
%

q(1) = sqrt(r'*r);
q(2) = r(1)/q(1);
q(3) = r(2)/q(1);
q(4) = r(3)/q(1);
q = q';
