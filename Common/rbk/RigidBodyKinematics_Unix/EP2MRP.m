function	q = EP2MRP(q1)

% EP2MRP(Q1)
%
%	Q = EP2MRP(Q1) translates the Euler parameter vector Q1
%	into the MRP vector Q.
%

q(1) = q1(2)/(1+q1(1));
q(2) = q1(3)/(1+q1(1));
q(3) = q1(4)/(1+q1(1));
q=q';
