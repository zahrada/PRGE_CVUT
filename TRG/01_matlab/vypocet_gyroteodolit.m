clc
clear all
format long g

souradnice = [
    1001	1055371.3	565726.4	835.35
    1002	1058509.0	560712.3	702.23
    1003	1055295.5	560932.6	732.23
    1004	1053013.0	559764.8	913.90
    1005	1055720.5	562455.4	558.36
];
cil = ['E' 'E' 'E' 'E' 'C']'; % 1001,...,1005

% CENTR nahrazen 0
% EXCIL nahrazen 1

% o = [
%     % orientace
%     1003 1005        86.9736      0
%     1003 1004       234.4063      0     % orientacni osnova
%     1003    1       114.8117  4.360+0.0175     % orientacni osnova (posledni udaj: vod. delka)
%     1003    0       101.0480  2.020+0.0175     % orientacni osnova (posledni udaj: vod. delka)
%     1003 1001       103.2894      0     % orientacni osnova 
%     1003 1002         0.0000      0     % orientacni osnova    
%     % stanovisko (1005 je centricke cili EXCIL a CENTR jsou v jednom bodì)
%                 1003 1005  87.0851  0 %1005
%                 1003 1004 234.4511  0   %1004
%                 1003    1 114.3284  6.033+0.0175
%                 1003    0 106.4568  3.678+0.0175
%                 1003 1001 103.3766  0   %1001
%                 1003 1002   0.0000  0   %1002  
%     
%     
%     ];

% % Vais
%  ex = 7.583*sin(dms2degrees([94 34 18])*pi/180) + 0.175;
%  g =  [1005 1003 68 34 38.0 0
%        1005    0 46 39 40.0 ex];

% % Florian
% ex = 7.583*sin(dms2degrees([94 34 18])*pi/180) + 0.0175;
%   g =  [1005 1003 68 34 53.0 0
%        1005    0 46 40 7.0 ex];

% % Mocová
% ex = 7.583*sin(dms2degrees([94 34 18])*pi/180) + 0.0175;
%   g =  [1005 1003 68 34 42 0
%        1005    0 46 39 51 ex];

% % Larina
% ex = 7.583*sin(dms2degrees([94 34 18])*pi/180) + 0.0175;
%   g =  [1005 1003 68 34 59 0
%        1005    0 46 42 27 ex];

% % Zípková
% ex = 7.576*sin(dms2degrees([94 10 3.6])*pi/180) + 0.0175;
%   g =  [1005 1003 68 44 53.69 0
%        1005    0 46 50 10.69 ex];

% % Kopáèek
% ex = 7.576*sin(dms2degrees([94 10 3.6])*pi/180) + 0.0175;
%   g =  [1005 1003 68 35 29.38 0
%        1005    0 46 40 54.38 ex];


% % Toulová
% ex = 7.576*sin(dms2degrees([94 21 3.6])*pi/180) + 0.0175;
%   g =  [1005 1003 68 35 52.21 0
%        1005     0 46 41 15.7 ex];

% % Jasenovská
% ex = 7.576*sin(dms2degrees([94 21 3.6])*pi/180) + 0.0175;
%   g =  [1005 1003 68 35 28.1 0
%        1005     0 46 40 27.1 ex];




o = [
    % orientace
    1003 1005        86.9736      0
    1003 1004       234.4063      0     % orientacni osnova
    1003    1       114.8117  4.360+0.0175     % orientacni osnova (posledni udaj: vod. delka)
    1003    0       101.0480  2.020+0.0175     % orientacni osnova (posledni udaj: vod. delka)
    1003 1001       103.2894      0     % orientacni osnova 
    1003 1002         0.0000      0     % orientacni osnova    
    % stanovisko (1005 je centricke cili EXCIL a CENTR jsou v jednom bodì)
];

% hladik
ex = 8.664*sin(dms2degrees([93 29 01])*pi/180) + 0.0175;
g =  [1005 1003 68 36 31.0 0
      1005    0 47 41 19.0 ex];
% % rokusek
% ex = 8.664*sin(dms2degrees([93 29 01])*pi/180) + 0.0175;
% g =  [1005 1003 68 36 19.8 0
%       1005    0 47 40 59.3 ex];
% % goby
% ex = 8.664*sin(dms2degrees([93 29 01])*pi/180) + 0.0175;
% g =  [1005 1003 68 36 31.8 0
%       1005    0 47 41  1.8 ex];
% % kulmon
% ex = 8.68 + 0.0175;
% g =  [1005 1003 68 36 43.1 0
%       1005    0 47 41 18.1 ex];
% % gruber
% ex = 8.68 + 0.0175;
% g =  [1005 1003 68 36 34.4 0
%       1005    0 47 41 21.4 ex];
% % kopecký
% ex = 8.68 + 0.0175;
% g =  [1005 1003 68 36 33.0 0
%       1005    0 47 41  8.0 ex];
  
%% prevod azimutu na smìrník
for(i = 1:size(g,1))    
    bod = g(i,1);
   	X = souradnice(souradnice(:,1)==bod,2);
   	Y = souradnice(souradnice(:,1)==bod,3); 
    A = dms2degrees(g(i,3:5))*pi/180;
    [smk] = azimuth2smk(A,X,Y);
    g(i,7) = smk*200/pi;
end
fprintf('============================================\n')
fprintf('               Gyroteodolit                 \n')
fprintf('--------------------------------------------\n')
fprintf('  Stan.   Smer  | Azimut[°''"]  Smìrník[gon]\n')
fprintf('--------------------------------------------\n')
for i = 1:size(g,1)
    if(g(i,2)==0)
        fprintf('%5.0f E\t%5.0f C\t|\t%2.0f %2.0f %2.0f\t%8.4f\n',g(i,1),g(i,1),g(i,3:5),g(i,7))
    else
        fprintf('%5.0f E\t%5.0f E\t|\t%2.0f %2.0f %2.0f\t%8.4f\n',g(i,1:5),g(i,7))
    end
        
end
fprintf('============================================\n')
%% doplnim osnovu smeru ( = smerniky) na excentru
for(i = 1:size(g,1))
    if(g(i,2)==0)
        o(end+1,:) = [g(i,1) g(i,2) g(i,7) g(i,6)];
        o(end+1,:) = [g(i,1)      1 g(i,7) g(i,6)];
    else
        o(end+1,:) = [g(i,1) g(i,2) g(i,7) g(i,6)];
    end
end
%% redukce smeru
[centrovaneSmery] = redukceSmeru(o,souradnice,cil);
fprintf('=========================================================================\n')
fprintf('                             Redukce smeru [gon]                         \n')
fprintf('-------------------------------------------------------------------------\n')
fprintf(' Stan.   Smer   |    Zmena  Korekce |     PsiPuv     PsiCentr      PsiKor\n')
fprintf('-------------------------------------------------------------------------\n')
for i = 1:size(centrovaneSmery,1)
    fprintf('%5.0f C\t%5.0f %s\t|\t%7.4f\t%7.4f\t|\t%9.4f\t%9.4f\t%9.4f\n',centrovaneSmery(i,1:2),cil(souradnice(:,1)==centrovaneSmery(i,2)),centrovaneSmery(i,3:end))
end
fprintf('=========================================================================\n')
%% vypocet smerniku
smerniky = [];
for(i = 1:size(g,1))
    if(g(2,i)~=0)
        smerniky(end+1,:) = centrovaneSmery(centrovaneSmery(:,1)==g(i,1) & centrovaneSmery(:,2)~=0,1:2);
        smerniky(end,end+1) = centrovaneSmery(centrovaneSmery(:,1)==g(i,1) & centrovaneSmery(:,2)~=0,end);
        
        bod1 = smerniky(end,1);
        X1 = souradnice(souradnice(:,1)==bod1,2);
        Y1 = souradnice(souradnice(:,1)==bod1,3);
        
        bod2 = smerniky(end,2);
        X2 = souradnice(souradnice(:,1)==bod2,2);
        Y2 = souradnice(souradnice(:,1)==bod2,3);

        smk = atan2(Y2-Y1,X2-X1);
        smk = zaradDoKvadrantu(smk);
        
        smerniky(end,end+1) = smk*200/pi;
        smerniky(end,end+1) = smerniky(end,4) - smerniky(end,3);
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