function [A,smk] = mereniNaSlunce(cas,psi,alfa_0,alfa_1,delta_0,delta_1,S0,UTC_TAI,DUT1,utcoffset,X,Y)
% ================
% vstupní hodnoty:
% ----------------
% cas             ... [rad] ... cas
% psi             ... [rad] ... smer na Slunce (leve rameno Slunce prave rameno strana)
% alfa_0,alfa_1   ... [rad] ... rektascenze z roèenky
% delta_0,delta_1 ... [rad] ... deklinace z roèenky
% S0              ... [rad] ... svetovy hvezdny cas pro 0:00 hod
% UTC_TAI         ... [rad] ... UTC - TAI (hodnota z IERS)
% DUT1            ... [rad] ... hodnota z IERS
% utcoffset       ... [h]   ... +1 pro zimni cas, +2 pro letni
% X,Y             ... [m]   ... souøadnice v S-JTSK
% =================
% výstupní hodnoty:
% -----------------
% A   ... [rad] ... azimut
% smk ... [rad] ... smernik
;
    % 1) konstantní hodnoty z IERS
    TT_TAI = -(32.184/3600)*pi/12;
    mu_1   = 1.00273790935;
    % 2) vypocet
    [B,L,c] = jtsk2bes(X,Y);
    UTC = cas - utcoffset*pi/12;
    TT = UTC + UTC_TAI + TT_TAI;
    alfa  = alfa_0 +(alfa_1 - alfa_0)*TT/(24*pi/12);
    delta = delta_0+(delta_1-delta_0)*TT/(24*pi/12);
    UT1 = UTC+DUT1;    
    t = UT1*mu_1 + S0 + L - alfa;
    A = atan2((cos(delta)*sin(t)),(cos(delta)*sin(B)*cos(t)-sin(delta)*cos(B)));
%     A = atan((cos(delta)*sin(t))/(cos(delta)*sin(B)*cos(t)-sin(delta)*cos(B)));
%     A = zaradDoKvadrantu(A);
    smk = A + (2*pi - psi) + c + (10/3600)*pi/180;   
    smk = zaradDoKvadrantu(smk);
end