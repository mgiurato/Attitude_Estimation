function	q = PRV2MRP(q1)

% PRV2MRP(Q1)
%
%	Q = PRV2MRP(Q1) translates the principal rotation vector Q1
%	into the MRP vector Q.
%

q1 = PRV2elem(q1);
tp = tan(q1(1)/4);
q(1) = q1(2)*tp;
q(2) = q1(3)*tp;
q(3) = q1(4)*tp;
q=q';
