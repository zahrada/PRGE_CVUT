function [Y X HBpv] = wgs842jtsk(BWGS84,LWGS84,HWGS84)
% [Y X] = wgs842jtsk(B,L,H)
% Transformace geodetickych souradnic B,L,H ve WGS84 do Y,X S-JTSK.
%
% Vstup: B geodeticka sirka [° ' "]
%        L geodeticka delka [° ' "]
%        H elipsoidicka vyska [m]
%
% Vystup: Y,X souradnice v S-JTSK [m]
%         HBpv vyska v Bpv
%
% Bc. Petr Pokorny, 2013

global aWGS84 eWGS84 aBess eBess

% konstanty elipsoidu
aWGS84 = 6378137;
bWGS84 = 6356752.31425;
eWGS84 = sqrt((aWGS84^2-bWGS84^2)/aWGS84^2);
aBess = 6377397.155;
eBess = sqrt(0.00667437223062);

BWGS84 = dms2degrees(BWGS84);
LWGS84 = dms2degrees(LWGS84);

% Transformace vysky
load('CR2005GRID.mat')

YY = []; XX = []; HH = [];

for PB = 1:size(BWGS84,1)
B = BWGS84(PB,1); L = LWGS84(PB,1); H = HWGS84(PB,1);

OB = zeros(2); OL = OB; ON = OB;
for i=1:size(Ngrid,2)-1
    for j=1:size(Ngrid,1)-1
        if B > Bgrid(1,i) && B < Bgrid(1,i+1) 
            if L > Lgrid(j,1) && L < Lgrid(j+1,1)
                OB = Bgrid(j:j+1,i:i+1);
                OL = Lgrid(j:j+1,i:i+1);
                ON = Ngrid(j:j+1,i:i+1);
            end
        end
    end
end

Bint = [];
SCALB = max(OB(1,:)); SCALL = max(OL(:,1));
OB = OB./SCALB; OL = OL./SCALL;
for i=1:2
    KB = polyfit(OB(i,:),ON(i,:),1);
    Bint = [Bint; polyval(KB,B/SCALB)];
end
KL = polyfit(OL(:,1),Bint,1);
N = polyval(KL,L/SCALL);

HBpv = H - N;

B = B/180*pi;
L = L/180*pi;

% Transformace souradnic
% 1: (B,L,H)GRS80 -> (X,Y,Z)GRS80
[XGRS80 YGRS80 ZGRS80] = krok1(B,L,H);
% fprintf('Transformace:\n')
% fprintf('%20s%20s%20s\n','X_WGS84 [m]','Y_WGS84 [m]','Z_WGS84 [m]')
% fprintf('%20.4f%20.4f%20.4f\n\n',XGRS80,YGRS80,ZGRS80)

% 2: (X,Y,Z)GRS80 -> (X,Y,Z)Bess
[XBess YBess ZBess] = krok2(XGRS80,YGRS80,ZGRS80,1);
% fprintf('%20s%20s%20s\n','X_Bess [m]','Y_Bess [m]','Z_Bess [m]')
% fprintf('%20.4f%20.4f%20.4f\n\n',XBess,YBess,ZBess)

% 3: (X,Y,Z)Bess -> (B,L,H)Bess
[BBess LBess HBess] = krok3(XBess,YBess,ZBess);
% fprintf('%20s%20s%20s\n','B_Bess [° '' "]','L_Bess [° '' "]','H_Bess [m]')
% fprintf('%9.0f%3.0f%8.4f%9.0f%3.0f%8.4f%20.4f\n\n',degrees2dms(BBess*180/pi),...
%                                                degrees2dms(LBess*180/pi),...
%                                                HBess)

% 4.0:
% LBess = LBess + LFerro;

% 4.1: (B,L)Bess -> (X',Y')
[XI YI] = krovak(BBess,LBess,1);
% fprintf('%20s%20s\n','X'' [m]','Y'' [m]')
% fprintf('%20.4f%20.4f\n\n',XI,YI)

% 4.2: (X',Y') -> (X,Y)SJTSK05
[X Y] = dotransformace(XI,YI,1);
% fprintf('%20s%20s\n','X_05 [m]','Y_05 [m]')
% fprintf('%20.4f%20.4f\n\n',X,Y)

% 5: (X,Y)SJTSK05 -> (X,Y)SJTSK
load('TABLEGRID.mat')
[dX dY] = krok5(X-5000000,Y-5000000,XTgrid,YTgrid,DXgrid,DYgrid);

XJTSK = X - 5000000 - dX;
YJTSK = Y - 5000000 - dY;

% fprintf('%20s%20s%20s\n','X_JTSK [m]','Y_JTSK [m]','H_Bpv [m]')
% fprintf('%20.4f%20.4f%20.4f\n\n',XJTSK,YJTSK,HBpv)

YY = [YY; YJTSK]; XX = [XX; XJTSK];
HH = [HH; HBpv];

end

Y = YY; X = XX; HBpv = HH;

end

function [X Y Z] = krok1(B,L,H)
global aWGS84 eWGS84
W = sqrt(1-eWGS84^2*sin(B)^2);
N = aWGS84/W;

X = (N+H)*cos(B)*cos(L);
Y = (N+H)*cos(B)*sin(L);
Z = (N*(1-eWGS84^2)+H)*sin(B);
end

function [Xout Yout Zout] = krok2(Xin,Yin,Zin,par)
if par == 1   % ETRF2000 -> JTSK/05
    t1 = -572.203; 
    t2 = -85.328; 
    t3 = -461.934; 
    m4 = -0.0000035393; 
    r5 = 5.24832714/206264.806; 
    r6 = 1.52900087/206264.806; 
    r7 = 4.97311727/206264.806;
end
if par == 2   % JTSK/05 -> ETRF2000
    t1 = 572.213; 
    t2 = 85.334; 
    t3 = 461.940; 
    m4 = 0.0000035378; 
    r5 = -5.24836073/206264.806; 
    r6 = -1.52899176/206264.806; 
    r7 = -4.97316164/206264.806;    
end
T = [t1;t2;t3]; M = (1+m4);
R = [1 r5 -r6; -r5 1 r7; r6 -r7 1];
Sin = [Xin;Yin;Zin];
Sout = T + M*R*Sin;
Xout = Sout(1,1); Yout = Sout(2,1); Zout = Sout(3,1);
end

function [B L H] = krok3(X,Y,Z)
global aBess eBess
L = atan2(Y,X);
P = sqrt(X^2+Y^2);
B = atan2(Z,P*(1-eBess^2));
W = sqrt(1-eBess^2*sin(B)^2);
N = aBess/W;
H = P/cos(B)-N;

test = 1; iterace = 1;
while test > 0.001
    iterace = iterace + 1;
    Ht = H;
    jmen = P*(1-N*eBess^2/(N+H));
    B = atan2(Z,jmen);
    W = sqrt(1-eBess^2*sin(B)^2);
    N = aBess/W;
    H = P/cos(B) - N;
    test = abs(H - Ht);
end
end

function [X Y] = krovak(B,L,par)
% (B,L)Bess -> (X',Y')
global aBess eBess
F0 = [49 30 00]; F0 = dms2degrees(F0)/180*pi;
alpha = sqrt(1+eBess^2*cos(F0)^4/(1-eBess^2));
U0 = asin(sin(F0)/alpha);
gF0 = ((1 + eBess*sin(F0))/(1 - eBess*sin(F0)))^(alpha*eBess/2);
k = tan(U0/2 + pi/4)*cot(F0/2 + pi/4)^alpha*gF0;
k1 = 0.9999;
N0 = aBess*sqrt(1-eBess^2)/(1-eBess^2*sin(F0)^2);
S0 = [78 30 00]; S0 = dms2degrees(S0)/180*pi;
n = sin(S0);
rho0 = k1*N0*cot(S0);
a2 = pi/2 - dms2degrees([59 42 42.69689])/180*pi;

if par == 1
    gB = ((1 + eBess*sin(B))/(1 - eBess*sin(B)))^(alpha*eBess/2);
    U = 2*(atan(k*tan(B/2 + pi/4)^alpha/gB) - pi/4);
    Lam = L + dms2degrees([17 40 00])/180*pi;

    DV = alpha*(dms2degrees([42 30 00])/180*pi - Lam);

    S = asin(cos(a2)*sin(U) + sin(a2)*cos(U)*cos(DV));
    D = asin(cos(U)*sin(DV)/cos(S));
    epsilon = n*D;

    rho = rho0*tan(S0/2 + pi/4)^n*cot(S/2 + pi/4)^n;

    X = rho*cos(epsilon);
    Y = rho*sin(epsilon);
end
if par == 2
    rho = sqrt(B^2 + L^2);
    eps = atan2(L,B);
    D = eps/sin(S0);
    S = 2*(atan((rho0/rho)^(1/n)*tan(S0/2 + pi/4)) - pi/4);
    U = asin(cos(a2)*sin(S) - sin(a2)*cos(S)*cos(D));
    DV = asin(cos(S)*sin(D)/cos(U));
    Y = dms2degrees([24 50 00])/180*pi - DV/alpha;
    
    X = U; tol = 1;
    while tol > 1e-18
       X0 = X;
       X = 2*(atan(k^(-1/alpha)*tan(U/2 + pi/4)^(1/alpha)*...
           (1+eBess*sin(X0))^(eBess/2)/(1-eBess*sin(X0))^(eBess/2))-pi/4);
       tol = abs(X - X0);
    end
    
end

end

function [X Y] = dotransformace(XI,YI,par)
A1 = 0.2946529277d-01;
A2 = 0.2515965696d-01;
A3 = 0.1193845912d-06;
A4 = -0.4668270147d-06;
A5 = 0.9233980362d-11;
A6 = 0.1523735715d-11;
A7 = 0.1696780024d-17;
A8 = 0.4408314235d-17;
A9 = -0.8331083518d-23;
A10 = -0.3689471323d-23;

if par == 1
    Xr = XI-1089000;
    Yr = YI-654000;
end
if par == 2
    Xr = XI-1089000-5000000;
    Yr = YI-654000-5000000;
end
XY2 = [Xr;Yr];
XY3 = [Xr^2 - Yr^2; 2*Yr*Xr];
XY4 = [Xr*(Xr^2 - 3*Yr^2);Yr*(3*Xr^2 - Yr^2)];
XY5 = [4*Yr*Xr*(Xr^2 - Yr^2); Xr^4 + Yr^4 - 6*Xr^2*Yr^2];
    
M1 = [A1;A2];
M2 = [A3 -A4; A4 A3];
M3 = [A5 -A6; A6 A5];
M4 = [A7 -A8; A8 A7];
M5 = [A9 A10; -A10 A9];
      
DXY = M1 + M2*XY2 + M3*XY3 + M4*XY4 + M5*XY5;

if par == 1
    X = XI - DXY(1) + 5000000;
    Y = YI - DXY(2) + 5000000;
end
if par == 2
    X = XI + DXY(1) - 5000000;
    Y = YI + DXY(2) - 5000000;
end

end

function [DX DY] = krok5(Xin,Yin,XTgrid,YTgrid,DXgrid,DYgrid)

% identifikace ctverce
for i = 2:size(YTgrid,1)-2
    for j = 2:size(XTgrid,2)-2
        O1X = XTgrid(i:i+1,j:j+1);
        O1Y = YTgrid(i:i+1,j:j+1);
        if Xin > O1X(1,1) && Xin < O1X(1,2) 
            if Yin > O1Y(1,1) && Yin < O1Y(2,1)
                OX = XTgrid(i-1:i+2,j-1:j+2);
                OY = YTgrid(i-1:i+2,j-1:j+2);
                ODX = DXgrid(i-1:i+2,j-1:j+2);
                ODY = DYgrid(i-1:i+2,j-1:j+2);
            end
        end
        
    end
end

SCALX = max(OX(1,:));
SCALY = max(OY(1,:));

OX = OX./SCALX;
OY = OY./SCALY;

XintDX = []; XintDY = [];
for i=1:4
    % x-ove souradnice
    KDX = polyfit(OX(i,:),ODX(i,:),3);
    XintDX = [XintDX; polyval(KDX,Xin/SCALX)];
    
    KDY = polyfit(OX(i,:),ODY(i,:),3);
    XintDY = [XintDY; polyval(KDY,Xin/SCALX)];
end

KDX = polyfit(OY(:,1),XintDX,3);
DX = polyval(KDX,Yin/SCALY);

KDY = polyfit(OY(:,1),XintDY,3);
DY = polyval(KDY,Yin/SCALY);
end