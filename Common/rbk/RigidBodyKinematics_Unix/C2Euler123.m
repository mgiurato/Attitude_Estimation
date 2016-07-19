function q = C2Euler123(C)

% C2Euler123
%
%	Q = C2Euler123(C) translates the 3x3 direction cosine matrix
%	C into the corresponding (1-2-3) Euler angle set.
%	

q(1) = atan2(-C(3,2),C(3,3));
q(2) = asin(C(3,1));
q(3)= atan2(-C(2,1),C(1,1));
q=q';
