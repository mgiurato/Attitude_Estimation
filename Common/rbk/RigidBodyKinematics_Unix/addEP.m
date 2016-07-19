function q = addEP(b1,b2)

% addEP(B1,B2)
%
%	Q = addEP(B1,B2) provides the Euler parameter vector
%	which corresponds to performing to successive
%	rotations B1 and B2.
%

q(1) = b2(1)*b1(1)-b2(2)*b1(2)-b2(3)*b1(3)-b2(4)*b1(4);
q(2) = b2(2)*b1(1)+b2(1)*b1(2)+b2(4)*b1(3)-b2(3)*b1(4);
q(3) = b2(3)*b1(1)-b2(4)*b1(2)+b2(1)*b1(3)+b2(2)*b1(4);
q(4) = b2(4)*b1(1)+b2(3)*b1(2)-b2(2)*b1(3)+b2(1)*b1(4);
q=q';
