function [D_red] = mat_red(mereni)

bod1 = mereni(1);
bod2 = mereni(2);
hT1 = mereni(3);
hT2 = mereni(4);


D = mereni(14);

R = 6380000;
k = 0.13;
r = R/k;

d = 2 * r * sin(D/(2*r));

[B,L,H]=najdi_souradnice(bod1);
[X_ETRF1,Y_ETRF1,Z_ETRF1,X_JTSK_rov1,Y_JTSK_rov1] = transformace(B,L,H,hT1);

[B,L,H]=najdi_souradnice(bod2);
[X_ETRF2,Y_ETRF2,Z_ETRF2,X_JTSK_rov2,Y_JTSK_rov2] = transformace(B,L,H,hT2);

d_XYZ0 = sqrt((X_ETRF1-X_ETRF2)^2 + (Y_ETRF1-Y_ETRF2)^2 +  (Z_ETRF1-Z_ETRF2)^2);
d_JTSK0 = sqrt((X_JTSK_rov1-X_JTSK_rov2)^2 + (Y_JTSK_rov1-Y_JTSK_rov2)^2);

D_red = d * (d_JTSK0/d_XYZ0);