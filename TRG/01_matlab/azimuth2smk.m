function [smk] = azimuth2smk(A,X,Y)
% ================
% vstupn� hodnoty:
% ----------------
% A   ... [rad] ... azimut
% X,Y ... [m]   ... sou�adnice v S-JTSK
% =================
% v�stupn� hodnoty:
% -----------------
% smk ... [rad] ... smernik
;
    [B,L,c] = jtsk2bes(X,Y);
    smk = A + c + (10/3600)*pi/180;
    smk = zaradDoKvadrantu(smk);
end