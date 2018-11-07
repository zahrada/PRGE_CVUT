function mainGEO
clc; clear all; close all;

%% Data GNSS - matice gnss
data_gnss;


%Cisla bodu profilu
CB = gnss(:,1);

% Souradnice bodu profilu
B = gnss(:,2:4);
L = gnss(:,5:7);
HEL = gnss(:,8);
sGNSS = gnss(:,end); % [m]

%% Data z nivelace
DATANIV = [
090 466.918  1.325  0 50
100 475.576 -0.307  0 12
121 484.696 -0.203  0 30
130 491.943 -1.347  0 10
140 499.829 -0.884  0 80
150 510.173 -1.565 -2 16
161 519.813 -0.106  0 12
180 527.501  0.656  0 15
210 540.260  0.357  0 20
230 524.437 -0.631  1 15
250 536.980 -2.626 -2 20
270 544.586  0.659  0 20
280 548.333 -0.584  1 20
290 556.244  0.000  0 0 
300 568.036 -1.391 -1 20
310 583.815 -0.382 -1 20
311 594.408 -0.897  2 20
320 601.329 -1.084  0 0 
331 616.595 -0.232  0 0 
340 634.090  0.000  0 0 % vyska z VPN !!!!!!!!!!!!!!!!!!!!!!
350 655.800  1.224  1 34 % vyska z VPN !!!!!!!!!!!!!!!!!!!!!!
360 667.929  0.000  0 0 % vyska z VPN !!!!!!!!!!!!!!!!!!!!!!
370 698.245 -0.085  1 10 % vyska z VPN !!!!!!!!!!!!!!!!!!!!!!
391 728.249 -0.680  2 6 % vyska z VPN !!!!!!!!!!!!!!!!!!!!!!
430 784.853  0.000  0 0 % vyska z VPN !!!!!!!!!!!!!!!!!!!!!!
440 800.813  0.000  0 0 % vyska z VPN !!!!!!!!!!!!!!!!!!!!!!
];

%% Interpolace odlehlosti kvazigeoidu od elipsoidu GRS80

% fprintf('Vstupní data:\n')
% fprintf('%20s%20s\n','B [° '' "]','L [° '' "]')
% fprintf('%9.0f%3.0f%8.4f%9.0f%3.0f%8.4f\n\n',B,L)

B = dms2degrees(B);
L = dms2degrees(L);

NB = size(B,1);

XIint = zeros(NB,1);
for i=1:NB
    XIint(i,1) = intGRID(B(i,1),L(i,1));
end
XIint;

%% Vypoctene HQ - z mereni nivelace (technicka nivelace pripojena na Bpv)
HQ = DATANIV(:,2)+DATANIV(:,3);

%% Vypoctene HEL - z mereni GNSS
HEL;

%% Porovnani odlehlosti XI - hodnoceni kvality modelu 
% Odlehlosti z mereni
XImer = HEL - HQ;

% Rozdil merenych a interpolovanych odlehlosti
DXI = XImer - XIint;

% DXImean = mean(DXI);
% vXI = DXImean - DXI;

% Vyberova smerodatna odchylka rozdilu mereneho a daneho modelu (globalni
% hodnoceni kvality modelu)
sDXI = sqrt(DXI'*DXI/(size(HQ,1)-1));

%% Hodnoceni kvality odlehlosti urcene z mereni 
% Stredni km chyba technicke nivelace
nR = size(DATANIV,1);
r = DATANIV(:,4);           % [mm]
R = DATANIV(:,5)/1000 ;     % [km]

m0TN = .5*sqrt(1/nR*sum(r.^2.*R));  % [mm]

% Stredni chyba jednotlivych nivelaci
mh = m0TN*sqrt(R);          % [mm]

% Smerodatna odchylka odlehlosti urcene z mereni (vliv podkladu lze
% zanedbat)

sXI = sqrt(sGNSS.^2 + (mh/1000).^2);    % [m]

% 95% interval
sXI95 = 1.96*sXI;           % [m]


%% Porovnani odlehlosti
% Vypocet souradnic bodu v JTSK pro vyneseni do grafu
[Y X] = wgs842jtsk(degrees2dms(B),degrees2dms(L),HEL);
save('YX.mat','Y','X')
load('YX.mat')

DY = Y(2:end,1) - Y(1:end-1,1);
DX = X(2:end,1) - X(1:end-1,1);
S = sqrt(DY.^2 + DX.^2);
Xplot = 0;
for i=1:size(S,1)
   Xplot = [Xplot; sum(S(1:i))];
end

Xplot = Xplot/1000;

LV = 1.5;
figure(1)
%subplot(2,1,1)
plot(Xplot,XImer,'g-','LineWidth',LV)
hold on
plot(Xplot,XIint,'r--','LineWidth',LV)
hold off
xlim([min(Xplot) max(Xplot)])
ylim([min(XImer) max(XImer)])
xlabel('d [km]')
ylabel('N [m]')
title('Porovnání odlehlostí N')
grid on
legend('mìøené N','interpolované N')

figure(2)
%subplot(2,1,2)
plot(Xplot,DXI,'gx-','MarkerEdgeColor','k')
xlim([min(Xplot) max(Xplot)])
ylim([min(DXI) max(DXI)])
xlabel('d [km]')
ylabel('\Delta N [m]')
title('Rozdíl odlehlostí \Delta N')
grid on

%% Vystup na terminal
OUT1 = [CB HEL HQ XImer XIint DXI sXI];
fprintf('Analýza odlehlostí\n')
fprintf('%10s%15s%15s%15s%15s%15s%15s\n','CB','HEL [m]','HQ [m]','XImer [m]','XIint [m]','DX [m]','smìrodatná odchylka [m]')
fprintf('%10.1f%15.3f%15.3f%15.3f%15.3f%15.3f%15.3f\n',OUT1')

fprintf('\nGlobální hodnocení kvality modelu\n')
fprintf('%10s%15.3f\n','sDXI [m]:',sDXI)



end

function [B L H] = krok3(X,Y,Z)
% Prevod kartezskych prostorovych souradnic X,Y,Z na elipsoidicke B,L,H.
aWGS84 = 6378137;
bWGS84 = 6356752.31425;
eWGS84 = sqrt((aWGS84^2-bWGS84^2)/aWGS84^2);

L = atan2(Y,X);
P = sqrt(X^2+Y^2);
B = atan2(Z,P*(1-eWGS84^2));
W = sqrt(1-eWGS84^2*sin(B)^2);
N = aWGS84/W;
H = P/cos(B)-N;

test = 1; iterace = 1;
while test > 0.001
    iterace = iterace + 1;
    Ht = H;
    jmen = P*(1-N*eWGS84^2/(N+H));
    B = atan2(Z,jmen);
    W = sqrt(1-eWGS84^2*sin(B)^2);
    N = aWGS84/W;
    H = P/cos(B) - N;
    test = abs(H - Ht);
end
end