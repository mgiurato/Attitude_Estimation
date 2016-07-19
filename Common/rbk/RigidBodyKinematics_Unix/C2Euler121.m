function q = C2Euler121(C)

% C2Euler121
%
%	Q = C2Euler121(C) translates the 3x3 direction cosine matrix
%	C into the corresponding (1-2-1) Euler angle set.
%	

q(1) = atan2(C(1,2),-C(1,3));
q(2) = acos(C(1,1));
q(3)= atan2(C(2,1),C(3,1));
q=q';
