function q = C2Euler131(C)

% C2Euler131
%
%	Q = C2Euler131(C) translates the 3x3 direction cosine matrix
%	C into the corresponding (1-3-1) Euler angle set.
%	

q(1) = atan2(C(1,3),C(1,2));
q(2) = acos(C(1,1));
q(3)= atan2(C(3,1),-C(2,1));
q=q';
