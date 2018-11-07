function [X,Y,Z] = el2cart(B,L,H,a,e)
% ================
% vstupn� hodnoty:
% ----------------
% B,L ... [rad] ... elipsoidick� sou�adnice
% H   ... [rad] ... elipsoidick8 v��ka
% a,e ... [rad] ... paramery elipsoidu
% =================
% v�stupn� hodnoty:
% -----------------
% X,Y,Z ... [m]   ... sou�adnice v prostoru
;
    N = a/sqrt(1-(e^2)*(sin(B)^2));
    X = (N+H)*cos(B)*cos(L);
    Y = (N+H)*cos(B)*sin(L);
    Z = (N*(1-(e^2))+H)*sin(B);
end