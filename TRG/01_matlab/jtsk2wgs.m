function [B_WGS,L_WGS,H_WGS] = jtsk2wgs(X_JTSK,Y_JTSK,H_Bessel,h)
% ================
% vstupní hodnoty:
% ----------------
% X_JTSK,Y_JTSK ... [m] ... souøadnice v S-JTSK
% H_Bessel      ... [m] ... vyska na Besselov2 elipsoidu
% h             ... [m/rad] ... transformaèní klíè
% =================
% výstupní hodnoty:
% -----------------
% B_WGS,L_WGS ... [rad] ... elipsoidické souøadnice na elipsoidu WGS84
% H_WGS       ... [m]   ... elipsoidická výška na elipsoidu WGS84
;
% a_WGS,e_WGS       ... [m] ... parametry elipsoidu WGS84
% a_Bessel,e_Bessel ... [m] ... parametry Besselova elipsoidu
    e_Bessel = sqrt(0.006674372230622);
    a_Bessel = 6377397.15508;
    e_WGS = sqrt(0.006694379990141);
    a_WGS = 6378137.0;
    [B_Bessel,L_Bessel] = jtsk2bes(X_JTSK,Y_JTSK);
    [X_Bessel,Y_Bessel,Z_Bessel] = el2cart(B_Bessel,L_Bessel,H_Bessel,a_Bessel,e_Bessel);
    [X_WGS,Y_WGS,Z_WGS] = helmertova7prvkova(X_Bessel,Y_Bessel,Z_Bessel,h);
    [B_WGS,L_WGS,H_WGS] = cart2el(X_WGS,Y_WGS,Z_WGS,a_WGS,e_WGS);
end