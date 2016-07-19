function	q = PRV2EP(q1)

% PRV2EP(Q1)
%
%	Q = PRV2EP(Q1) translates the principal rotation vector Q1
%	into the Euler parameter vector Q.
%

q1 = PRV2elem(q1);
sp = sin(q1(1)/2);
q(1) = cos(q1(1)/2);
q(2) = q1(2)*sp;
q(3) = q1(3)*sp;
q(4) = q1(4)*sp;
q=q';
