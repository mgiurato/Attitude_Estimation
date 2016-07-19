function C = DirCos(mode,q,sequence)

% DIRCOS	Direction cosine matrix
%	C = DirCos(MODE,Q,SEQUENCE) returns the 3x3 direction cosine 
%	matrix for a given attitude vector q.  The integer flag MODE selects 
%	which type of attitude parameters are begin used.  
%
%	The SEQUENCE string is only used if the Euler angles (MODE 2)
%	are used.  If no SEQUENCE is given, then the function
% 	defaults to the standard 3-2-1 yaw, pitch and roll set.  If the 
%	sequence (3-1-3) would be used, then the command would be
%		DirCos(2,Q,'313')
%
%	For the Euler parameters (MODE 1), the first element of the
%	4x1 vector is the scalar Euler parameter component, while the
%	remaining three form the Eulerparameter vector.
%
%	If mode 5, the prinicpal rotation vector, is used, then Q can be
%	either a 4x1 or 3x1 vector.  The first element of the 4x1 vector 
%	is the prinicpal rotation angle phi, while the remaining elements 
%	form the unit prinicpal rotation vector e.  The 3x1 vector is the 
%	principal rotation vector scaled by the rotation angle.
%		Q = [phi,e]   	or 	Q = [phi*e]
%
%	MODE		ATTITUDE PARAMETERS
%	   1			Euler parameter/quaternions
%	   2			Euler angles (default is the (3-2-1) set)
%	   3			modified Rodrigues parameters
%	   4			classical Rodrigues parameters or Gibbs vector
%	   5			prinicpal rotation vector
%

if size(mode)~= [1 1], error('MODE must be a scalar value.'); end
if (mode<1)|(mode>5), error('MODE is out of range of 1:5.'); end
if round(mode)~= mode, error('MODE must be an integer.'); end

if (~isequal(size(q), [3 1]))&(~isequal(size(q), [4 1]))
	error('Q has the wrong dimension.'); 
end
if (~isreal(q)),error('Q must have real components.');end


switch mode
	case	1	% 	Euler Parameters
		if (~isequal(size(q),[4 1]))
			error('Q must be a 4x1 vector for this MODE.');
		end
		C = DirCosEP(q);
	case 	2	% 	Euler angles
		if (~isequal(size(q),[3 1]))
			error('Q must be a 3x1 vector for this MODE.');
		end
		if (nargin==2) 
			sequence = '321';
		end
		switch sequence
			case	'321'
				C = DirCosEuler321(q);
			case '313'
				C = DirCosEuler313(q);
			case '312'
				C = DirCosEuler312(q);
			case '123'
				C = DirCosEuler123(q);
			case '132'
				C = DirCosEuler132(q);
			case '213'
				C = DirCosEuler213(q);
			case '231'
				C = DirCosEuler231(q);
			case '323'
				C = DirCosEuler323(q);
			case '121'
				C = DirCosEuler121(q);
			case '131'
				C = DirCosEuler131(q);
			case '232'
				C = DirCosEuler232(q);
			case '212'
				C = DirCosEuler212(q);
		end
	case	3	%	MRP
		if (~isequal(size(q),[3 1]))
			error('Q must be a 3x1 vector for this MODE.');
		end
		C = DirCosMRP(q);
	case 4	%	Gibbs vector
		if (~isequal(size(q),[3 1]))
			error('Q must be a 3x1 vector for this MODE.');
		end
		C = DirCosGibbs(q);
	case 5	%	principal rotation vector
		if length(q)==3
			q0 = sqrt(q'*q);
			q2 = [q0;q(1)/q0;q(2)/q0;q(3)/q0];
			C = DirCosPRV(q2);
		else 
			C = DirCosPRV(q);
		end
end
