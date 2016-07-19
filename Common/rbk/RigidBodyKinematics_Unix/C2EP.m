function b = C2EP(C)

% C2EP
%
%	Q = C2EP(C) translates the 3x3 direction cosine matrix
%	C into the corresponding 4x1 Euler parameter vector Q,
%	where the first component of Q is the non-dimensional
%	Euler parameter Beta_0 >= 0. Transformation is done
%	using the Stanley method.i
%	

tr = C(1,1)+C(2,2)+C(3,3);
b2(1) = (1+tr)/4;
b2(2) = (1+2*C(1,1)-tr)/4;
b2(3) = (1+2*C(2,2)-tr)/4;
b2(4) = (1+2*C(3,3)-tr)/4;

[v,i] = max(b2);
switch i
	case 1
		b(1) = sqrt(b2(1));
		b(2) = (C(2,3)-C(3,2))/4/b(1);
		b(3) = (C(3,1)-C(1,3))/4/b(1);
		b(4) = (C(1,2)-C(2,1))/4/b(1);
	case 2
		b(2) = sqrt(b2(2));
		b(1) = (C(2,3)-C(3,2))/4/b(2);
		if (b(1)<0)
			b(2) = -b(2);
			b(1) = -b(1);
		end
		b(3) = (C(1,2)+C(2,1))/4/b(2);
		b(4) = (C(3,1)+C(1,3))/4/b(2);
	case 3
		b(3) = sqrt(b2(3));
		b(1) = (C(3,1)-C(1,3))/4/b(3);
		if (b(1)<0)
			b(3) = -b(3);
			b(1) = -b(1);
		end
		b(2) = (C(1,2)+C(2,1))/4/b(3);
		b(4) = (C(2,3)+C(3,2))/4/b(3);
	case 4
		b(4) = sqrt(b2(4));
		b(1) = (C(1,2)-C(2,1))/4/b(4);
		if (b(1)<0)
			b(4) = -b(4);
			b(1) = -b(1);
		end
		b(2) = (C(3,1)+C(1,3))/4/b(4);
		b(3) = (C(2,3)+C(3,2))/4/b(4);
end
b = b';
