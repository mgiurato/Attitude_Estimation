function	q = MRP2PRV(q1)

% MRP2PRV(Q1)
%
%	Q = MRP2PRV(Q1) translates the MRP vector Q1
%	into the principal rotation vector Q.
%

tp = sqrt(q1'*q1);
p = 4*atan(tp);
q(1) = q1(1)/tp*p;
q(2) = q1(2)/tp*p;
q(3) = q1(3)/tp*p;
q=q';
