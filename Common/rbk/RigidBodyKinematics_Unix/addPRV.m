function q = addPRV(q1,q2)

% addPRV(Q1,Q2)
%
%	Q = addPRV(Q1,Q2) provides the principal rotation vector
%	which corresponds to performing to successive
%	prinicipal rotations Q1 and Q2.
%

q1 = PRV2elem(q1);
q2 = PRV2elem(q2);
cp1 = cos(q1(1)/2);
cp2 = cos(q2(1)/2); 
sp1 = sin(q1(1)/2);
sp2 = sin(q2(1)/2);
e1 = q1(2:4);
e2 = q2(2:4);

p = 2*acos(cp1*cp2-sp1*sp2*e1'*e2);
sp = sin(p/2);
e = (cp1*sp2*e2+cp2*sp1*e1+sp1*sp2*cross(e1,e2))/sp;
q = p*e;