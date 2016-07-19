function q = C2Euler213(C)

% C2Euler213
%
%	Q = C2Euler213(C) translates the 3x3 direction cosine matrix
%	C into the corresponding (2-1-3) Euler angle set.
%	

q(1) = atan2(C(3,1),C(3,3));
q(2) = asin(-C(3,2));
q(3)= atan2(C(1,2),C(2,2));
q=q';
