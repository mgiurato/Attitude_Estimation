function q = Picheck(x)

% Picheck(x)
%
% 	Makes sure that the angle x lies within +/- Pi.
%


q = x;

if (x>pi) q = x-2*pi;
end
if (x<-pi) q = x+2*pi;
end
