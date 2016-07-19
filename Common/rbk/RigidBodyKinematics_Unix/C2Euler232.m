function q = C2Euler232(C)

% C2Euler232
%
%	Q = C2Euler232(C) translates the 3x3 direction cosine matrix
%	C into the corresponding (2-3-2) Euler angle set.
%	

q(1) = atan2(C(2,3),-C(2,1));
q(2) = acos(C(2,2));
q(3)= atan2(C(3,2),C(1,2));
q=q';
