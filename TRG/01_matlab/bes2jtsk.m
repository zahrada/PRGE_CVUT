function [X,Y,c] = bes2jtsk(B,L)
% ================
% vstupní hodnoty:
% ----------------
% B,L ... [rad] souøadnice na Besselovì ellipsoidu
% =================
% výstupní hodnoty:
% -----------------
% X,Y ... [m]   souøadnice v S-JTSK
% c   ... [rad] meridiánová konvergence
;
    % 1) Krovakovo zobrazeni - konstanty
    UQ  = (59 + 42/60 + 42.69690/3600)*pi/180;
    S0  = (78 + 30/60)*pi/180;
    fi0 = (49 + 30/60)*pi/180;
    lambda0 = (24 + 50/60)*pi/180;
    % 2) Besseluv elipsoid - konstanty
    e = sqrt(0.006674372230622);
    a = 6377397.15508;
    % 3) Vypocet konstant
    % R    = a*sqrt(1-(e^2))/(1-(e^2)*(sin(fi0)^2)) 
    % - melo by to vyjit, ale nevychazi to
    R    = 6380703.610500;
    alfa = sqrt(1+(e^2)*((cos(fi0))^4)/(1-(e^2)));
    U0   = asin(sin(fi0)/alfa);
    k1   = ((1-e*sin(fi0))/(1+e*sin(fi0)))^(alfa*e/2);
    k2   = tan(fi0/2 + pi/4)^(alfa);
    k3   = tan( U0/2 + pi/4);
    k    = k1*k2/k3;
    rho0 = R*0.9999/tan(S0);
    n    = sin(S0);
    % 4) Prevod
    u1 = (1/k)*(((1-e*sin(B))/(1+e*sin(B)))^(alfa*e/2));
    u2 = tan((B/2)+pi/4)^alfa;
    U = 2*atan(u1*u2)-(pi/2);
    dV = alfa*(lambda0 - L);
    S = asin(sin(UQ)*sin(U) + cos(UQ)*cos(U)*cos(dV));
    D = asin(sin(dV)*cos(U)/cos(S));
    rho1 = tan((S0/2) + (pi/4))^n;
    rho2 = tan((S/2)  + (pi/4))^n;
    rho = rho0*rho1/rho2;
    omega = n*D;
    Y = rho*sin(omega);
    X = rho*cos(omega);
    epsilon = atan2(Y,X);
    % 5) Meridianova konvergence
    dzeta = asin(cos(UQ)*sin(D)/cos(U));
    c = epsilon - dzeta;
    % 6) zarazeni vsech uhlu do kvadrantu
    c = zaradDoKvadrantu(c);
end