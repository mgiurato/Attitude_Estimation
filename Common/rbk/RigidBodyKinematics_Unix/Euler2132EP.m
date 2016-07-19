function q = Euler2132EP(e)

% Euler2132EP(E)
%
%	Q = Euler2132EP(E) translates the 213 Euler angle
%	vector E into the Euler parameter vector Q.
%

c1 = cos(e(1)/2);
s1 = sin(e(1)/2);
c2 = cos(e(2)/2);
s2 = sin(e(2)/2);
c3 = cos(e(3)/2);
s3 = sin(e(3)/2);

q(1) = c1*c2*c3+s1*s2*s3;
q(2) = c1*s2*c3+s1*c2*s3;
q(3) = s1*c2*c3-c1*s2*s3;
q(4) = c1*c2*s3-s1*s2*c3;
q=q';
