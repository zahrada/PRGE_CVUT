function [smk] = azimuth2smk(A,X,Y)
% ================
% vstupní hodnoty:
% ----------------
% A   ... [rad] ... azimut
% X,Y ... [m]   ... souøadnice v S-JTSK
% =================
% výstupní hodnoty:
% -----------------
% smk ... [rad] ... smernik
;
    [B,L,c] = jtsk2bes(X,Y);
    smk = A + c + (10/3600)*pi/180;
    smk = zaradDoKvadrantu(smk);
end