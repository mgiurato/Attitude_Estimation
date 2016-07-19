qq = [.1,.2,.3];

Q = [0 -qq(3) qq(2);qq(3) 0 -qq(1);-qq(2) qq(1) 0];

C = (eye(3)-Q)*inv(eye(3)+Q);

q = C2Gibbs(C);

 BmatGibbs(q)*BinvGibbs(q)

 BmatMRP(q)*BinvMRP(q)

BmatPRV(q)*BinvPRV(q)

q = C2Euler121(C);
 BmatEuler121(q)*BinvEuler121(q)

q = C2Euler123(C);
 BmatEuler123(q)*BinvEuler123(q)

q = C2Euler131(C);
 BmatEuler131(q)*BinvEuler131(q)

q = C2Euler132(C);
 BmatEuler132(q)*BinvEuler132(q)

q = C2Euler313(C); 
BmatEuler313(q)*BinvEuler313(q)

q = C2Euler312(C); 
BmatEuler312(q)*BinvEuler312(q)

q = C2Euler321(C); 
BmatEuler321(q)*BinvEuler321(q)

q = C2Euler323(C); 
BmatEuler323(q)*BinvEuler323(q)

q = C2Euler212(C); 
BmatEuler212(q)*BinvEuler212(q)

q = C2Euler213(C); 
BmatEuler213(q)*BinvEuler213(q)

q = C2Euler232(C); 
BmatEuler232(q)*BinvEuler232(q)

q = C2Euler231(C); 
BmatEuler231(q)*BinvEuler231(q)

