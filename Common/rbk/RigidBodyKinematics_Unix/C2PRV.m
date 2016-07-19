function q = C2PRV(C)

% C2PRV
%
%	Q = C2PRV(C) translates the 3x3 direction cosine matrix
%	C into the corresponding 3x1 principal rotation vector Q,
%	where the first component of Q is the principal rotation angle
%	phi (0<= phi <= Pi)
%	

cp = (C(1,1) + C(2,2) + C(3,3)-1)/2;
p = acos(cp);
sp = p/2/sin(p);
q(1) = (C(2,3)-C(3,2))*sp;
q(2) = (C(3,1)-C(1,3))*sp;
q(3) = (C(1,2)-C(2,1))*sp;
q = q';
