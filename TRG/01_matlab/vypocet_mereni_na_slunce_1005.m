clc
clear all
format long g
% hodnoty z tabulek
alfa_0  = ( 12 +  10/60 + 29.5/3600)*pi/12;
alfa_1  = ( 12 +  14/60 + 5.4/3600)*pi/12;
delta_0 = (-1 + 8/60 + 12/3600)*pi/180;
delta_1 = (-1 +  31/60 + 33/3600)*pi/180;
S0      = (0 +  18/60 +  59.729/3600)*pi/12;

% alfa_0  = ( 4 +  5/60 + 54.1  /3600)*pi/12;
% alfa_1  = ( 4 +  9/60 + 56.6  /3600)*pi/12;
% delta_0 = (20 + 50/60 + 56    /3600)*pi/180;
% delta_1 = (21 +  1/60 + 42    /3600)*pi/180;
% S0      = (16 +  9/60 +  3.193/3600)*pi/12;
% hodnoty z IERS
UTC_TAI = -(37/3600)*pi/12;
DUT1    = ( 0.0 /3600)*pi/12;
% cas
utcoffset = 2; % letni cas

% CENTR nahrazen 0
% EXCIL nahrazen 1

souradnice = [
1001	1055371.3	565726.4	835.35
1002	1058509.0	560712.3	702.23
1003	1055295.5	560932.6	732.23
1004	1053013.0	559764.8	913.90
1005	1055720.5	562455.4	558.36
];
cil = ['E' 'E' 'E' 'E' 'C']'; % 1001,...,1005

o_ori = [
    % orientace
10O2 1003        60.1813            % orientacni osnova
10O2 1004        75.2950            % orientacni osnova
10O2    1        16.3576  4.737     % orientacni osnova (posledni udaj: vod. delka)EXCIL
10O2    0       127.2205  6.180     % orientacni osnova (posledni udaj: vod. delka)CENTR
10O2 1001         0.0000            % orientacni osnova 
%     1003 1005        86.9736      0
%     1003 1004       234.4063      0     % orientacni osnova
%     1003    1       114.8117  4.360+0.0175     % orientacni osnova (posledni udaj: vod. delka)
%     1003    0       101.0480  2.020+0.0175     % orientacni osnova (posledni udaj: vod. delka)
%     1003 1001       103.2894      0     % orientacni osnova 
%     1003 1002         0.0000      0     % orientacni osnova    
    % stanovisko (1005 je centricke cili EXCIL a CENTR jsou v jednom bodì)
    ];

% data Kulmon
o_stan = [
    1005 1003         0.0000      0            % orientacni osnova
    1005    0       366.2552  2.805+0.0175     % orientacni osnova (posledni udaj: vod. delka)    
    1005    1       366.2552  2.805+0.0175     % orientacni osnova (posledni udaj: vod. delka)  
];
a = [1002 1003    234.1251 10:54:40.7    235.3157 10:58:29.7    60.3418
     1003 1003    309.1586 14:35:58.7    309.8712 14:38:17.7    60.3429];
 
% % data Goby
% o_stan = [
%     1005 1003         0.0000      0     % orientacni osnova
%     1005    0       301.5729  3.917+0.0175     % orientacni osnova (posledni udaj: vod. delka)    
%     1005    1       301.5729  3.917+0.0175     % orientacni osnova (posledni udaj: vod. delka)  
% ];
% a = [1005 1003    240.7651 18 55 42.9    241.1179 18 57 28.2    0.0000
%      1005 1003    242.6649 19 05 10.3    242.9732 19 06 42.5    0.0000];
 
% % data Gruber
% o_stan = [
%     1005 1003         0.0000      0     % orientacni osnova
%     1005    0       128.0733  3.941+0.0175     % orientacni osnova (posledni udaj: vod. delka)    
%     1005    1       128.0733  3.941+0.0175     % orientacni osnova (posledni udaj: vod. delka)  
% ];
% a = [1005 1003    238.4599 18 45 46.4    238.9086 18 48 00.0    0.0000
%      1005 1003    239.8803 18 52 49.6    240.1851 18 54 20.7    0.0000];

% % data Kopecký
% o_stan = [
%     1005 1003         0.0000      0     % orientacni osnova
%     1005    0       128.0691  3.941+0.0175     % orientacni osnova (posledni udaj: vod. delka)    
%     1005    1       128.0691  3.941+0.0175     % orientacni osnova (posledni udaj: vod. delka)  
% ];
% a = [1005 1003    234.2375 18 24 52.0    234.5764 18 26 32.6    0.0000
%      1005 1003    235.3621 18 30 24.8    235.6661 18 31 55.4    0.0000];
 
% % data Hladík
% o_stan = [
%     1005 1003         0.0000      0     % orientacni osnova
%     1005    0       307.7342  3.863+0.0175     % orientacni osnova (posledni udaj: vod. delka)    
%     1005    1       307.7342  3.863+0.0175     % orientacni osnova (posledni udaj: vod. delka)  
% ];
% a = [1005 1003    244.3939 19 13 46.8    244.6503 19 15 03.5    0.0000
%      1005 1003    245.9496 19 21 29.9    246.1690 19 22 35.2    0.0000];
 
% % data Rokusek
% o_stan = [
%     1005 1003         7.6373      0     % orientacni osnova
%     1005    0       373.9069  2.805+0.0175     % orientacni osnova (posledni udaj: vod. delka)    
%     1005    1       373.9069  2.805+0.0175     % orientacni osnova (posledni udaj: vod. delka)  
% ];
% a = [1005 1003    247.0696 18 49 35.5    247.3918 18 51 11.2    7.6375
%      1005 1003    248.1075 18 54 45.8    248.4032 18 56 14.0    7.6370];

%% pouzita konvergence
X = souradnice(souradnice(:,1)==o_stan(1,1),2);
Y = souradnice(souradnice(:,1)==o_stan(1,1),3);
[B,L,c] = jtsk2bes(X,Y);
c = degrees2dms(c*180/pi);
fprintf('Pouzitá meridiánová konvergence %2.0f° %2.0f'' %2.1f"\n',c)
 
%% prevod azimutu na smìrník
azimuty = [];
for i = 1:size(a,1)    
    % vypocet smerniku
    bod = a(i,1);
    X = souradnice(souradnice(:,1)==bod,2);
    Y = souradnice(souradnice(:,1)==bod,3);
    psi = [];
    cas = [];
    for j = 3:4:size(a,2)
        if(j~=size(a,2))
            psi(end+1) =  a(i,j) - a(i,end); % prave - leve
            cas(end+1) = (a(i,j+1) + a(i,j+2)/60 + a(i,j+3)/3600)*pi/12;
        end
    end
    for j = 1:length(psi)
        [A,smk] = mereniNaSlunce(cas(j),psi(j)*pi/200,alfa_0,alfa_1,delta_0,delta_1,S0,UTC_TAI,DUT1,utcoffset,X,Y);        
        azimuty(end+1,:) = [a(i,1) a(i,2) A*200/pi smk*200/pi a(i,end)];
    end
end
fprintf('=====================================\n')
fprintf('         Vypocet smerniku [gon]      \n')
fprintf('-------------------------------------\n')
fprintf(' Stan.   Smer     Azimut      Smernik\n')
fprintf('-------------------------------------\n')
for(i = 1:size(azimuty,1))
    fprintf('%5.0f\t%5.0f\t%9.4f\t%9.4f\n',azimuty(i,1:end-1))
end
fprintf('=====================================\n')
% prevedeni osnovy smeru na excentru na smerniky
osnova = [];
for(i = 1:size(azimuty,1))
    for(j = 1:size(o_stan,1))
        [azimuty(i,4),o_stan(j,3),azimuty(i,end)]';
      	smk = azimuty(i,4) + (o_stan(j,3) - azimuty(i,end));
       	smk = zaradDoKvadrantu(smk*pi/200)*200/pi;
     	osnova(end+1,:) = [i o_stan(j,1) o_stan(j,2) smk o_stan(j,4)]; 
    end
end
smerniky = [];
for(i = 1:size(azimuty,1))
    o = o_ori;
    for(j = 1:size(osnova,1))
        if(i == osnova(j,1))
            o(end+1,:) = osnova(j,2:end);
        end
    end
    [centrovaneSmery] = redukceSmeru(o,souradnice,cil);
    fprintf('=========================================================================\n')
    fprintf('                             Redukce smeru [gon]                         \n')
    fprintf('-------------------------------------------------------------------------\n')
    fprintf(' Stan.   Smer   |    Zmena  Korekce |     PsiPuv     PsiCentr      PsiKor\n')
    fprintf('-------------------------------------------------------------------------\n')
    for j = 1:size(centrovaneSmery,1)
        fprintf('%5.0f C\t%5.0f %s\t|\t%7.4f\t%7.4f\t|\t%9.4f\t%9.4f\t%9.4f\n',centrovaneSmery(j,1:2),cil(souradnice(:,1)==centrovaneSmery(j,2)),centrovaneSmery(j,3:end))
    end
    fprintf('=========================================================================\n')
    for j = 1:size(centrovaneSmery,1)
        if(azimuty(i,1)==centrovaneSmery(j,1) && azimuty(i,2)==centrovaneSmery(j,2))
            bod1 = centrovaneSmery(j,1);
            X1 = souradnice(souradnice(:,1)==bod1,2);
            Y1 = souradnice(souradnice(:,1)==bod1,3); 
        
            bod2 = centrovaneSmery(j,2);
            X2 = souradnice(souradnice(:,1)==bod2,2);
            Y2 = souradnice(souradnice(:,1)==bod2,3);
                
            mabyt = atan2(Y2-Y1,X2-X1);
            mabyt = zaradDoKvadrantu(mabyt)*200/pi;
            smerniky(end+1,:) = [centrovaneSmery(j,1) centrovaneSmery(j,2) centrovaneSmery(j,end) mabyt mabyt-centrovaneSmery(j,end)];
        end
    end
end

fprintf('=======================================================\n')
fprintf('                      Smernik [gon]                    \n')
fprintf('-------------------------------------------------------\n')
fprintf(' Stan.   Smer   |     Vysl.      Ze souø.   |    Odleh.\n')
fprintf('-------------------------------------------------------\n')
for i = 1:size(smerniky,1)
    fprintf('%5.0f\t%5.0f\t|\t%9.4f\t%9.4f\t|\t%7.4f\n',smerniky(i,:))
end
fprintf('=======================================================\n')