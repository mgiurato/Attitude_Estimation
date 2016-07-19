function q = C2Euler132(C)

% C2Euler132
%
%	Q = C2Euler132(C) translates the 3x3 direction cosine matrix
%	C into the corresponding (1-3-2) Euler angle set.
%	

q(1) = atan2(C(2,3),C(2,2));
q(2) = asin(-C(2,1));
q(3)= atan2(C(3,1),C(1,1));
q=q';
