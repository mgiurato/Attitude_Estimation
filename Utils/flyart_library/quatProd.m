function quat = quatProd( quat1, quat2 )
%quatProd Hemiltonian product between two quaternions
%
%   quat = quatProd( quat1, quat2 )
%
%   This function compute the hamiltonian product between two quaternions
%   written as 4-by-1 vectors with the scalar component as the fourth
%   element of the vector.

qv1 = quat1(1:3);
qs1 = quat1(4);

qv2 = quat2(1:3);
qs2 = quat2(4);

quat = [qs2*qv1 + qs1*qv2 - cross( qv1, qv2 ) ;
             qs1*qs2 - dot( qv1, qv2 )       ];
end

