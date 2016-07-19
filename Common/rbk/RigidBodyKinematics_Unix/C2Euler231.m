function q = C2Euler231(C)

% C2Euler231
%
%	Q = C2Euler231(C) translates the 3x3 direction cosine matrix
%	C into the corresponding (2-3-1) Euler angle set.
%	

q(1) = atan2(-C(1,3),C(1,1));
q(2) = asin(C(1,2));
q(3)= atan2(-C(3,2),C(2,2));
q=q';
