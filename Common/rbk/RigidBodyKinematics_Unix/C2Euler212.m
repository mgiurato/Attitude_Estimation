function q = C2Euler212(C)

% C2Euler212
%
%	Q = C2Euler212(C) translates the 3x3 direction cosine matrix
%	C into the corresponding (2-1-2) Euler angle set.
%	

q(1) = atan2(C(2,1),C(2,3));
q(2) = acos(C(2,2));
q(3)= atan2(C(1,2),-C(3,2));
q=q';
