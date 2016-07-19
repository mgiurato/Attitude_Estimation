function	q = MRP2EP(q1)

% MRP2EP(Q1)
%
%	Q = MRP2EP(Q1) translates the MRP vector Q1
%	into the Euler parameter vector Q.
%

ps = 1+q1'*q1;
q(1) = (1-q1'*q1)/ps;
q(2) = 2*q1(1)/ps;
q(3) = 2*q1(2)/ps;
q(4) = 2*q1(3)/ps;
q=q';
