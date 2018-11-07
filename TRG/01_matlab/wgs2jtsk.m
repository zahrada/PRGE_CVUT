function [X_JTSK,Y_JTSK,c] = wgs2jtsk(B_WGS,L_WGS,H_WGS,h)
% ================
% vstupn� hodnoty:
% ----------------
% B_WGS,L_WGS       ... [rad]   ... elipsoidick� sou�adnice na elipsoidu WGS84
% H_WGS             ... [m]     ... elipsoidick� v��ka na elipsoidu WGS84
% h                 ... [m/rad] ... transforma�n� kl��
% =================
% v�stupn� hodnoty:
% -----------------
% X_JTSK,Y_JTSK ... [m] ... sou�adnice v S-JTSK
% c             ... [c] ... meridi�nov� konvergence
;
% a_WGS,e_WGS       ... [m] ... parametry elipsoidu WGS84
% a_Bessel,e_Bessel ... [m] ... parametry Besselova elipsoidu
    e_Bessel = sqrt(0.006674372230622);
    a_Bessel = 6377397.15508;
    e_WGS = sqrt(0.006694379990141);
    a_WGS = 6378137.0;
    [X_WGS,Y_WGS,Z_WGS]          = el2cart(B_WGS,L_WGS,H_WGS,a_WGS,e_WGS);
    [X_Bessel,Y_Bessel,Z_Bessel] = helmertova7prvkova(X_WGS,Y_WGS,Z_WGS,h);
    [B_Bessel,L_Bessel]          = cart2el(X_Bessel,Y_Bessel,Z_Bessel,a_Bessel,e_Bessel); % H_Bessel nepotrebujeme
    [X_JTSK,Y_JTSK,c]            = bes2jtsk(B_Bessel,L_Bessel);
end