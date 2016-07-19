function q = elem2PRV(r)

% elem2PRV(R)
%	
%	Q = elem2PRV(R) translates a prinicpal rotation 
%	element set R into the corresponding principal 
%	rotation vector Q.
%

q(1) = r(2)*r(1);
q(2) = r(3)*r(1);
q(3) = r(4)*r(1);
q = q';
