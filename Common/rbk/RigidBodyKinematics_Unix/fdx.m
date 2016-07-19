function dx = fdx(r,dr)

dx = [dr;dr];
rm = sqrt(r'*r);
re = 6378.2;
J2 = 1082.64e-6;
mu = 398601.2;
rer = re/rm;
zr = r(3)/rm;

dx(4) = - mu*r(1)/rm/rm/rm*(1-1.5*J2*rer*rer*(5*zr*zr-1));
dx(5) = - mu*r(2)/rm/rm/rm*(1-1.5*J2*rer*rer*(5*zr*zr-1));
dx(6) = - mu*r(3)/rm/rm/rm*(1-1.5*J2*rer*rer*(5*zr*zr-3));