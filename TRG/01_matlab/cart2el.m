function [B,L,H] = cart2el(X,Y,Z,a,e)
% ================
% vstupní hodnoty:
% ----------------
% X,Y,Z ... [m]   ... souøadnice v prostoru
% a,e   ... [rad] ... paramery elipsoidu
% =================
% výstupní hodnoty:
% -----------------
% B,L ... [rad] ... elipsoidické souøadnice
% H   ... [rad] ... elipsoidická výška
;
    L = atan2(Y,X);            
    B = atan2(Z,(1-(e^2))*sqrt(X^2 + Y^2));
    B_tmp = B + 1;
    while (abs(B-B_tmp) > 1e-16)
        B_tmp = B;
        N = a/sqrt(1-(e^2)*(sin(B)^2));
        B = atan2(Z+N*(e^2)*sin(B),sqrt(X^2+Y^2));
    end
    H = sqrt(X^2+Y^2)/(cos(L)-a/sqrt(1-(e^2)*(sin(L)^2)));
end
