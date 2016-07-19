function q = C2Euler312(C)

% C2Euler312
%
%	Q = C2Euler312(C) translates the 3x3 direction cosine matrix
%	C into the corresponding (3-1-2) Euler angle set.
%	

q(1) = atan2(-C(2,1),C(2,2));
q(2) = asin(C(2,3));
q(3)= atan2(-C(1,3),C(3,3));
q=q';
