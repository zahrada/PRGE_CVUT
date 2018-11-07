function [A] = smk2azimuth(smk,X,Y)
% ================
% vstupn� hodnoty:
% ----------------
% smk ... [rad] ... smernik
% X,Y ... [m]   ... sou�adnice v S-JTSK
% =================
% v�stupn� hodnoty:
% -----------------
% A   ... [rad] ... azimut
;
    [B,L,c] = jtsk2bes(X,Y);
    A = smk - c - (10/3600)*pi/180;
    A = zaradDoKvadrantu(A);
end