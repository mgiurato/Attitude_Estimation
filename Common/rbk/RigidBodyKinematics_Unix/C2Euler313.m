function q = C2Euler313(C)

% C2Euler313
%
%	Q = C2Euler313(C) translates the 3x3 direction cosine matrix
%	C into the corresponding (3-1-3) Euler angle set.
%	

q(1) = atan2(C(3,1),-C(3,2));
q(2) = acos(C(3,3));
q(3)= atan2(C(1,3),C(2,3));
q=q';
