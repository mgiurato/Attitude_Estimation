function q = C2Euler321(C)

% C2Euler321
%
%	Q = C2Euler321(C) translates the 3x3 direction cosine matrix
%	C into the corresponding (3-2-1) Euler angle set.
%	

q(1) = atan2(C(1,2),C(1,1));
q(2) = asin(-C(1,3));
q(3)= atan2(C(2,3),C(3,3));
q=q';
