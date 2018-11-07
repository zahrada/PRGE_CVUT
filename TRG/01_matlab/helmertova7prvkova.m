function [X2,Y2,Z2] = helmertova7prvkova(X1,Y1,Z1,h)
% ================
% vstupn� hodnoty:
% ----------------
% X1,Y1,Z1 ... [m]   ... sou�adnice ve vstupn� soustav�
% h        ... [rad] ... transforma�n� kl��
% =================
% v�stupn� hodnoty:
% -----------------
% X1,Y1,Z1 ... [m]   ... sou�adnice ve v�stupn� soustav�
;
    A(1,1:7) = [0 -Z1 Y1 1 0 0 X1];
    A(2,1:7) = [Z1 0 -X1 0 1 0 Y1];
    A(3,1:7) = [-Y1 X1 0 0 0 1 Z1];
    x = A*h;
    X2 = x(1);
    Y2 = x(2);
    Z2 = x(3);
end