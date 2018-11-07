clc
clear all
format long g
%%
% testovací skript
%% jtsk2bes / bes2jtsk
X = 1000000.00;
Y =  750000.00;
[B,L,c] = jtsk2bes(X,Y);
[X,Y,c] = bes2jtsk(B,L);
%% azimuth2smk
X = 1000000.00;
Y =  750000.00;
azimuth2smk(dms2degrees([74 05 31])*pi/180,X,Y);
%% mereniNaSlunce
% 1) merena data
cas = (8 + 39/60 + 27.2/3600)*pi/12;
psi = 368.8039*pi/200;      
% 2) hodnoty z tabulek
alfa_0  = ( 0 + 14/60 + 45.5  /3600)*pi/12;
alfa_1  = ( 0 + 18/60 + 24.4  /3600)*pi/12;
delta_0 = ( 1 + 35/60 + 54    /3600)*pi/180;
delta_1 = ( 1 + 59/60 + 29    /3600)*pi/180;
S0      = (12 +  8/60 + 33.416/3600)*pi/12;
% 3) hodnoty z IERS
UTC_TAI = -(35    /3600)*pi/12;
DUT1    = -( 0.6  /3600)*pi/12;
% 4) cas
utcoffset = 1; % zimni cas
% 5) stanovisko
Y =  744945.041;
X = 1040891.676;
[A,smk] = mereniNaSlunce(cas,psi,alfa_0,alfa_1,delta_0,delta_1,S0,UTC_TAI,DUT1,utcoffset,X,Y);
%% redukceDelekNaSpojniciKratke
R = 6380703.610500; % polomer besselova elipsoidu
[Dred,delta] = redukceDelekNaSpojniciKratke(1500.15,215.1558*pi/200,250.024,1.502,1.054,R);
%% redukceDelekNaSpojniciDlouhe
R = 6380703.610500; % polomer besselova elipsoidu
[Dred,delta] = redukceDelekNaSpojniciKratke(1500.15,750.012,810.125,1.502,1.054,R);
%% excentricke stanovisko
smery = [193.1731;199.6463;241.4432;358.9260]*pi/200;
delky = [1950.9;1745.9;2549.9;1.540];
[smery] = excentrickeStanovisko(smery,delky);
[smery*200/pi];
%% excentricky cil
psi = 0.0015*pi/200;
smery = [57.8412 325.3412]*pi/200;
delky = [1396.2 0.090];
[psi,delka] = excentrickyCil(psi,smery,delky);
[psi*200/pi delka]';
%% prevod mezi wgs84 a s-jtsk (ovìøeno s ArcGisem + PROJ4)
e_Bessel = sqrt(0.006674372230622);
a_Bessel = 6377397.15508;
e_WGS = sqrt(0.006694379990141);
a_WGS = 6378137.0;
B_WGS = (50+10/60)*pi/180;
L_WGS = (15+50/60)*pi/180;
H_WGS = 0;
h = [4.998*pi/(60*60*180),1.587*pi/(60*60*180),5.261*pi/(60*60*180)...
    ,-570.8,-85.7,-462.8,1-3.56*10^(-6)]'; % tr. klic
[X_WGS,Y_WGS,Z_WGS]          = el2cart(B_WGS,L_WGS,H_WGS,a_WGS,e_WGS);
[X_Bessel,Y_Bessel,Z_Bessel] = helmertova7prvkova(X_WGS,Y_WGS,Z_WGS,h);
[B_Bessel,L_Bessel,H_Bessel] = cart2el(X_Bessel,Y_Bessel,Z_Bessel,a_Bessel,e_Bessel);
[X_JTSK,Y_JTSK,c]            = bes2jtsk(B_Bessel,L_Bessel);
[X_JTSK,Y_JTSK,c]';
%% prevod mezi wgs84 a s-jtsk (ovìøeno s ArcGisem + PROJ4) - v jedne funkci + konstanty uvnitø
B_WGS = (50+10/60)*pi/180;
L_WGS = (15+50/60)*pi/180;
H_WGS = 0;
h = [4.998*pi/(60*60*180),1.587*pi/(60*60*180),5.261*pi/(60*60*180)...
    ,-570.8,-85.7,-462.8,1-3.56*10^(-6)]'; % tr. klic
[X_JTSK,Y_JTSK,c] = wgs2jtsk(B_WGS,L_WGS,H_WGS,h);
[X_JTSK,Y_JTSK,c]';
%% jtsk > wgs (souradnice B,L jsou snad dobøe, ale H asi není moc pøesné)
e_Bessel = sqrt(0.006674372230622);
a_Bessel = 6377397.15508;
e_WGS = sqrt(0.006694379990141);
a_WGS = 6378137.0;
X_JTSK   = 1047096.9658272;
Y_JTSK   = 641543.964661719;
H_Bessel = -0.641647048504631;
h = [-4.998*pi/(60*60*180),-1.587*pi/(60*60*180),-5.261*pi/(60*60*180)...
    ,+570.8,+85.7,+462.8,(1+3.56*10^(-6))]'; % tr. klic
[B_Bessel,L_Bessel,c] = jtsk2bes(X_JTSK,Y_JTSK);
[X_Bessel,Y_Bessel,Z_Bessel] = el2cart(B_Bessel,L_Bessel,H_Bessel,a_Bessel,e_Bessel);
[X_WGS,Y_WGS,Z_WGS] = helmertova7prvkova(X_Bessel,Y_Bessel,Z_Bessel,h);
[B_WGS,L_WGS,H_WGS] = cart2el(X_WGS,Y_WGS,Z_WGS,a_WGS,e_WGS);
[degrees2dms(B_WGS*180/pi),degrees2dms(L_WGS*180/pi),H_WGS]';
%% jtsk > wgs (v jednom kroku)
X_JTSK   = 1047096.9658272;
Y_JTSK   = 641543.964661719;
H_Bessel = -0.641647048504631;
h = [-4.998*pi/(60*60*180),-1.587*pi/(60*60*180),-5.261*pi/(60*60*180)...
    ,+570.8,+85.7,+462.8,(1+3.56*10^(-6))]'; % tr. klic
[B_WGS,L_WGS,H_WGS] = jtsk2wgs(X_JTSK,Y_JTSK,H_Bessel,h);
%% fyzikalni a matematicke redukce - Lukešùv pøíklad - liším se od nìho o 2 mm
Dmer = 4795.849;
t1 = 15;
p1 = 697;
h1 = 57;
t2 = 21;
p2 = 700;
h2 = 57;
X1_JTSK = 1055371.3;
Y1_JTSK =  565726.4;
X2_JTSK = 1055295.5;
Y2_JTSK =  560932.6;
H1_Bessel = 835.3448;
H2_Bessel = 732.2301;
hT1 = 1.664;
hT2 = 1.485;
k = 0.13;
R = 6380000;
[Dfyz,delta1] = fyzikalniRedukce(Dmer,t1,t2,p1,p2,h1,h2);
[Dmat,delta2] = matematickeRedukceJtsk(Dfyz,X1_JTSK,Y1_JTSK,H1_Bessel,X2_JTSK,Y2_JTSK,H2_Bessel,hT1,hT2,R,k);
%% centrace specialni pripad (Kulmon)
[71.7368 0.0020]';
psiS11  = 208.5766*pi/200;
psiS1C1 = 145.3909*pi/200;
psiS1C2 =  71.7368*pi/200;
psiS22  = 190.7410*pi/200;
psiS2C2 = 180.2603*pi/200;
psiS2C1 =   0.0020*pi/200;
SS11  = 6.575;
SS1C1 = 4.114;
SS22  = 3.270;
SS2C2 = 7.705;
sour = [1058509.0 560712.3;1055295.5 560932.6];
S12 = norm(sour(1,:) - sour(2,:));
[psi12,psi21,dalfa12,dalfa21] = centraceSmeru(psiS11,psiS1C1,psiS1C2,psiS22,psiS2C2,psiS2C1,SS11,SS1C1,SS22,SS2C2,S12);
[dalfa12*200/pi dalfa21*200/pi]';
[psi12*200/pi psi21*200/pi]';

% obracene
[71.7368 0.0020]';
psiS11  = 190.7410*pi/200;
psiS1C1 = 180.2603*pi/200;
psiS1C2 =   0.0020*pi/200;

psiS22  = 208.5766*pi/200;
psiS2C2 = 145.3909*pi/200;
psiS2C1 =  71.7368*pi/200;

SS11  = 3.270;
SS1C1 = 7.705;

SS22  = 6.575;
SS2C2 = 4.114;

sour = [1058509.0 560712.3;1055295.5 560932.6];
S12 = norm(sour(1,:) - sour(2,:));
[psi12,psi21,dalfa12,dalfa21] = centraceSmeru(psiS11,psiS1C1,psiS1C2,psiS22,psiS2C2,psiS2C1,SS11,SS1C1,SS22,SS2C2,S12);
[dalfa12*200/pi dalfa21*200/pi]';
[psi12*200/pi psi21*200/pi]';

%% lukesuv priklad
psiS11  = 208.5766*pi/200;
psiS1C1 = 145.3909*pi/200;
psiS1C2 =  71.7368*pi/200;
psiS22  = 190.7410*pi/200;
psiS2C2 = 180.2603*pi/200;
psiS2C1 =   0.0020*pi/200;
SS11  = 6.575;
SS1C1 = 4.114;
SS22  = 3.270;
SS2C2 = 7.705;
sour = [1058509.0 560712.3;1055295.5 560932.6];
S12 = norm(sour(1,:) - sour(2,:));
[delta] = centracniZmena(psiS11,psiS1C1,psiS1C2,psiS22,psiS2C2,psiS2C1,SS11,SS1C1,SS22,SS2C2,S12);
delta*200/pi



