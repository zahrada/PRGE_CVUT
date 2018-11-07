function [X,Y,Z] = el2cart(B,L,H,a,e)
% ================
% vstupní hodnoty:
% ----------------
% B,L ... [rad] ... elipsoidické souøadnice
% H   ... [rad] ... elipsoidick8 výška
% a,e ... [rad] ... paramery elipsoidu
% =================
% výstupní hodnoty:
% -----------------
% X,Y,Z ... [m]   ... souøadnice v prostoru
;
    N = a/sqrt(1-(e^2)*(sin(B)^2));
    X = (N+H)*cos(B)*cos(L);
    Y = (N+H)*cos(B)*sin(L);
    Z = (N*(1-(e^2))+H)*sin(B);
end