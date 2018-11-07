function [B,L,c] = jtsk2bes(X,Y)
% ================
% vstupní hodnoty:
% ----------------
% X,Y ... [m]   souøadnice v S-JTSK
% =================
% výstupní hodnoty:
% -----------------
% B,L ... [rad] souøadnice na Besselovì ellipsoidu
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
    rho     = sqrt(X^2 + Y^2);
    epsilon = atan2(Y,X);
    S = 2*atan2(((rho0/rho)^(1/n))*tan(S0/2 + pi/4),1) - pi/2;
    D = epsilon/n;
    U  = asin(sin(UQ)*sin(S)-cos(UQ)*cos(S)*cos(D));
    dV = asin(sin(D)*cos(S)/cos(U));
    L = lambda0 - dV/alfa;
    B(1) = U;
    diff = 2*pi;
    i = 2;
    while(diff > 1e-16)
        B(i) = 2*atan2((k^(1/alfa))*(((1-e*sin(B(i-1)))/( ...
                1+e*sin(B(i-1))))^(-e/2))*( ...
                tan(U/2 + pi/4)^(1/alfa)),1) - pi/2;
        diff = abs(B(i) - B(i-1));
        i = i+1;
    end
    B = B(size(B,2));
    % 5) Meridianova konvergence
    dzeta = asin(cos(UQ)*sin(D)/cos(U));
    c = epsilon - dzeta;
    % 6) zarazeni vsech uhlu do kvadrantu
    B = zaradDoKvadrantu(B);
    L = zaradDoKvadrantu(L);
    c = zaradDoKvadrantu(c);
end