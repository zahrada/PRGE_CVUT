function [X2,Y2,Z2] = helmertova7prvkova(X1,Y1,Z1,h)
% ================
% vstupní hodnoty:
% ----------------
% X1,Y1,Z1 ... [m]   ... souøadnice ve vstupní soustavì
% h        ... [rad] ... transformaèní klíè
% =================
% výstupní hodnoty:
% -----------------
% X1,Y1,Z1 ... [m]   ... souøadnice ve výstupní soustavì
;
    A(1,1:7) = [0 -Z1 Y1 1 0 0 X1];
    A(2,1:7) = [Z1 0 -X1 0 1 0 Y1];
    A(3,1:7) = [-Y1 X1 0 0 0 1 Z1];
    x = A*h;
    X2 = x(1);
    Y2 = x(2);
    Z2 = x(3);
end