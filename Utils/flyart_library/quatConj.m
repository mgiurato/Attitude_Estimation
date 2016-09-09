function quatCon = quatConj( quat )
%quatConj Calculate the conjugate of a quaternion
%
%   quatCon = quatConj( quat )
%
%   This function calculates the conjugate of a quaternion written as a
%   4-by-1 vector with the scalar component as the fourth element of the
%   vector.

qv = quat(1:3);
qs = quat(4);

quatCon = [ -qv  ;
              qs ];
end

