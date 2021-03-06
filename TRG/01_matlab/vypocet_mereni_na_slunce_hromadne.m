clc
clear all
format long g
% blbnou kvadranty u azimut� nev�m pro�

% hodnoty z IERS
UTC_TAI = -(37    /3600)*pi/12;
DUT1    = ( 0.0  /3600)*pi/12;
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

%% 1. turnus skupina �.1
% hodnoty z tabulek
alfa_0  = ( 12 +  10/60 + 29.5/3600)*pi/12;
alfa_1  = ( 12 +  14/60 + 5.4/3600)*pi/12;
delta_0 = (-1 + 8/60 + 12/3600)*pi/180;
delta_1 = (-1 +  31/60 + 33/3600)*pi/180;
S0      = (0 +  18/60 +  59.729/3600)*pi/12;
% alfa_0  = ( 3 + 37/60 + 50.5  /3600)*pi/12;
% alfa_1  = ( 3 + 41/60 + 49.4  /3600)*pi/12;
% delta_0 = (19 + 25/60 + 41    /3600)*pi/180;
% delta_1 = (19 + 38/60 + 54    /3600)*pi/180;
% S0      = (15 + 41/60 + 27.282/3600)*pi/12;

% orienta�n� osnovy 26.9.2018
o = [         1001    0        20.5617   6.867    % orientacni osnova (posledni udaj: vod. delka opravena o souctovou konstantu minihranolu) CENTR
              1001    1         0.0000   4.806    % orientacni osnova (posledni udaj: vod. delka opravena o souctovou konstantu minihranolu) EXCIL
              1001 1002        89.8642   0        % orientacni osnova 
              1001 1003        53.2671   0        % orientacni osnova               
              1001 1004        30.2735   0        % orientacni osnova    
              1002    0       127.2205   6.180    % orientacni osnova (posledni udaj: vod. delka)CENTR              
              1002    1        16.3576   4.737    % orientacni osnova (posledni udaj: vod. delka)EXCIL
              1002 1001         0.0000   0        % orientacni osnova 
              1002 1003        60.1813   0        % orientacni osnova
              1002 1004        75.2950   0        % orientacni osnova
              1003    0        26.0180   6.299    % orientacni osnova (posledni udaj: vod. delka - m��eno na miniHRANOL Leica)  CENTR              
              1003    1       391.5348   4.545    % orientacni osnova (posledni udaj: vod. delka - m��eno p�smem) EXCIL
              1003 1001       103.0592   0        % orientacni osnova
              1003 1002         0.0000   0        % orientacni osnova
              1003 1004       234.2683   0        % orientacni osnova
              1004    0        32.7153   6.979    % orientacni osnova (posledni udaj: vod. delka) Pozn.: minihranol Leica CENTR
              1004    1        41.8323   4.010    % orientacni osnova (posledni udaj: vod. delka) Pozn.: pasmo EXCIL
              1004 1001        64.9939   0        % orientacni osnova 
              1004 1002         0.0000   0        % orientacni osnova
              1004 1003        19.0285   0        % orientacni osnova
   
              ];  
%m��en� na slunce 26.9.2018
a = [
1001 1003      0      00 00 00.0       0         0 0  0         0
1001 1003      0      00 00 00.0       0         0 0  0         0   
1002 1003    234.1251 10 54 40.7     235.3157   10 58 29.7     60.3418
1002 1003    309.1586 14 35 58.7     309.8712   14 38 17.7     60.3429    
1003 1001    375.4442 11 00 2.5      375.8294   11 01 17.5    103.0699
1003 1001    376.8287 11 04 25.0     377.1352   11 05 22.0    103.0687
1003 1001    186.9664 14 51 24.50    187.7251   14 53 55.0    236.5750
1003 1001    189.1156 14 58 36.00    189.4912   14 59 53.00   236.5764
1004 1002     46.2276 15 18 16.15     47.5403   15 22 58.15     0.1183
1004 1003     23.3336 15 05 7.50      23.9006   15 07 6.5       0.0085
1004 1003    319.7132 15 41 20.35    320.5008   15 44 19.55   286.3026
];

%rameno 1002 - 1004 je asi �patn�
% o = [          1001    0  14.8563  8.702+0.0175 %CENTR   
%                1001    1   0.0424  10.642+0.0175 %EXCIL
%                1001 1002 165.5762  0   %1002 
%                1001 1003 128.9423  0   %1003   
%                1001 1004 105.9842  0 %1004                
%                1002    0  81.1728  6.387+0.0175 %CENTR 
%                1002    1 102.1876  9.748+0.0175 %EXCIL 
%                1002 1001 375.7912  0   %1001
%                1002 1003 35.8154   0   %1003   
%                1002 1004 51.0830   0 %1004                 
%                1003    0 106.4568  3.678+0.0175 %CENTR 
%                1003    1 114.3284  6.033+0.0175 %EXCIL 
%                1003 1001 103.3766  0   %1001
%                1003 1002   0.0000  0   %1002  
%                1003 1004 234.4511  0   %1004
%                1003 1005  87.0851  0 %1005  
%                1004    0 279.0010 6.594+0.0175 %CENTR 
%                1004    1 360.0327 3.874+0.0175 %EXCIL
%                1004 1001 262.9634 0    %1001
%                1004 1002 197.8034 0    %1002  
%                1004 1003 217.2082 0    ];  

% %% 2. turnus skupina �.2 (1002 p�evzato od 2. turnus skupina �.1)
% % hodnoty z tabulek
% alfa_0  = ( 4 +  5/60 + 54.1  /3600)*pi/12;
% alfa_1  = ( 4 +  9/60 + 56.6  /3600)*pi/12;
% delta_0 = (20 + 50/60 + 56    /3600)*pi/180;
% delta_1 = (21 +  1/60 + 42    /3600)*pi/180;
% S0      = (16 +  9/60 + 3.193/3600)*pi/12;
% 
% o = [
%     1001 1004        1.0314  0         	% orientacni osnova
%     1001 1003		 24.0042 0		% orientacni osnova
%     1001 1002		 60.6087 0		% orientacni osnova
%     1001 1          281.7762 6.169+0.0175    	% orientacni osnova (posledni udaj: vod. delka)
%     1001 0			307.2676 3.919+0.0175		% orientacni osnova (posledni udaj: vod. delka)
%     1002 1001   362.9214  0         % orientacni osnova
% 	1002 1003    23.0237  0         % orientacni osnova
% 	1002 1004    38.2871  0			% orientacni osnova
% 	1002    1    76.6947  6.170+0.0175     % orientacni osnova (posledni udaj: vod. delka)
% 	1002    0   131.0747  6.357+0.0175     % orientacni osnova (posledni udaj: vod. delka)
%     1003 1002         0.0000 0           % orientacni osnova
%     1003 1005        87.0725 0          % orientacni osnova
%     1003 1001       103.3200 0          % orientacni osnova
%     1003    1      143.0540  5.716+0.0175     % orientacni osnova (posledni udaj: vod. delka)
%     1003    0      154.8143  3.439+0.0175     % orientacni osnova (posledni udaj: vod. delka)
%     1003 1004       234.3648 0          % orientacni osnova
%     1004 1002        0.0000  0          % orientacni osnova
%     1004 1003       19.3323  0          % orientacni osnova
%     1004 1001       65.0767  0          % orientacni osnova
%     1004    0       80.4380  7.201+0.0175     % orientacni osnova (posledni udaj: vod. delka)
%     1004    1      152.7047  4.013+0.0175    % orientacni osnova (posledni udaj: vod. delka)
%     %1004 1001   399.9997      0     % orientacni osnova (chyba v datech)
% ];
% a = [  % POZOR !!! v poslednim sloupci jsou uvedeny chybne udaje  
%     1001 1003    221.6571 17 24 33.24    221.9719 17 25 59.40    178.1948
%     1001 1003    222.7585 17 29 39.78    223.1460 17 31 27.95    177.5555
%     1001 1003    225.2688 17 41 25.66    225.5182 17 42 36.91    174.1114
%     1001 1003    226.0146 17 44 58.54    226.2354 17 46 1.62     173.8799
%     1004 1003    221.3846 17 25 42.70    222.1687 17 27 16.70    178.0272
%     1004 1003    223.2306 17 32 33.52    223.5675 17 34 10.68    176.6030
%     1004 1003    225.5194 17 44 53.64    225.8568 17 46 29.30    174.3131
%     1004 1003    226.3862 17 49 00.34    226.6771 17 50 23.40    173.4692
%     % 1005 1003    224.3232 17:37:46.9    224.6852 17:40:6.51    371.2561   # 6. polozka je smer na centr, KTERA BYLA MERENA POUZE 1x PRO JEDNOHO MERICE
%     % 1005 1003    225.4778 17:43:51.9    225.8243 17:45:30.4    371.2561     
%     % 1005 1003    235.3567 18:29:24.2    235.7048 18:31:7.4     371.2573
%     % 1005 1003    236.3321 18:34:13.5    236.5877 18:35:29.8    371.2573
% ];
% a = [  % POZOR !!! v poslednim sloupci jsou uvedeny chybne udaje  
%     1001 1003    221.6571 17 24 33.24    221.9719 17 25 59.40    16.1766
%     1001 1003    222.7585 17 29 39.78    223.1460 17 31 27.95    16.1766
%     1001 1003    225.2688 17 41 25.66    225.5182 17 42 36.91    16.1766
%     1001 1003    226.0146 17 44 58.54    226.2354 17 46 1.62     16.1766
%     1004 1003    221.3846 17 25 42.70    222.1687 17 27 16.70    147.0500
%     1004 1003    223.2306 17 32 33.52    223.5675 17 34 10.68    147.0500
%     1004 1003    225.5194 17 44 53.64    225.8568 17 46 29.30    147.0500
%     1004 1003    226.3862 17 49 00.34    226.6771 17 50 23.40    147.0500
%     % 1005 1003    224.3232 17:37:46.9    224.6852 17:40:6.51    371.2561   # 6. polozka je smer na centr, KTERA BYLA MERENA POUZE 1x PRO JEDNOHO MERICE
%     % 1005 1003    225.4778 17:43:51.9    225.8243 17:45:30.4    371.2561     
%     % 1005 1003    235.3567 18:29:24.2    235.7048 18:31:7.4     371.2573
%     % 1005 1003    236.3321 18:34:13.5    236.5877 18:35:29.8    371.2573
% ];



%% pouzita konvergence
for(i = 1:size(souradnice,1))
    X = souradnice(i,2);
    Y = souradnice(i,3);
    [B,L,c] = jtsk2bes(X,Y);
    c = degrees2dms(c*180/pi);
    fprintf('%5.0f - pou�it� meridi�nov� konvergence %2.0f� %2.0f'' %2.1f"\n',souradnice(i,1),c)
end 
%% prevod azimutu na sm�rn�k
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
    %psi;
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

% [centrovaneSmery] = redukceSmeru(o,souradnice,cil);
% fprintf('=========================================================================\n')
% fprintf('                             Redukce smeru [gon]                         \n')
% fprintf('-------------------------------------------------------------------------\n')
% fprintf(' Stan.   Smer   |    Zmena  Korekce |     PsiPuv     PsiCentr      PsiKor\n')
% fprintf('-------------------------------------------------------------------------\n')
% for j = 1:size(centrovaneSmery,1)
%     fprintf('%5.0f C\t%5.0f %s\t|\t%7.4f\t%7.4f\t|\t%9.4f\t%9.4f\t%9.4f\n',centrovaneSmery(j,1:2),cil(souradnice(:,1)==centrovaneSmery(j,2)),centrovaneSmery(j,3:end))
% end
% fprintf('=========================================================================\n')

centrovaneSmerniky = [];
for(i = 1:size(azimuty,1))
    % najdu ty spravne radky s osnovami
    o_ori  = o(find(o(:,1)==azimuty(i,2) & (o(:,2)==azimuty(i,1) | o(:,2)==0 | o(:,2)==1)),:);  
    o_stan = o(find(o(:,1)==azimuty(i,1) & (o(:,2)==azimuty(i,2) | o(:,2)==0 | o(:,2)==1)),:); 
    % najdu puvodni smer na orientaci
    smerOri = o_stan(find(o_stan(:,1)==azimuty(i,1) & o_stan(:,2)==azimuty(i,2)),3);    
    % je potreba pootocit s osnovou
    diff = azimuty(i,end-1) - smerOri;
    for(j = 1:size(o_stan,1))
    	o_stan(j,3) = zaradDoKvadrantu((o_stan(j,3) + diff)*pi/200)*200/pi;
    end    
    % spojim osnovy na stanovisku a na orientaci
    o_vyber = o_ori;
    o_vyber(end+1:end+3,:) = o_stan;
    o_vyber;
    % provedu centraci a smerove korekce
    [centrSm] = redukceSmeru(o_vyber,souradnice,cil);    
    centrovaneSmerniky(end+1,:) = centrSm(find(centrSm(:,1)==azimuty(i,1) & centrSm(:,2)==azimuty(i,2)),:);
end
fprintf('=========================================================================\n')
fprintf('                           Redukce smerniku [gon]                        \n')
fprintf('-------------------------------------------------------------------------\n')
fprintf(' Stan.   Smer   |    Zmena  Korekce |     SmkPuv     SmkCentr      SmkKor\n')
fprintf('-------------------------------------------------------------------------\n')
for j = 1:size(centrovaneSmerniky,1)
    fprintf('%5.0f E\t%5.0f %s\t|\t%7.4f\t%7.4f\t|\t%9.4f\t%9.4f\t%9.4f\n',centrovaneSmerniky(j,1:2),cil(souradnice(:,1)==centrovaneSmerniky(j,2)),centrovaneSmerniky(j,3:end))
end
fprintf('=========================================================================\n')
% porovn�n� se sou�adnicemi
smerniky = [];
for(i = 1:size(centrovaneSmerniky,1))
    smerniky(i,1) = centrovaneSmerniky(i,1);
    smerniky(i,2) = centrovaneSmerniky(i,2);
    smerniky(i,3) = centrovaneSmerniky(i,end);
    
    bod1 = smerniky(i,1);
    X1 = souradnice(souradnice(:,1)==bod1,2);
    Y1 = souradnice(souradnice(:,1)==bod1,3); 
    
    bod2 = smerniky(i,2);
    X2 = souradnice(souradnice(:,1)==bod2,2);
    Y2 = souradnice(souradnice(:,1)==bod2,3); 
    
    mabyt = atan2(Y2-Y1,X2-X1);
    mabyt = zaradDoKvadrantu(mabyt)*200/pi;
    
    smerniky(i,4) = mabyt;
    smerniky(i,5) = mabyt - smerniky(i,3);
end
fprintf('=======================================================\n')
fprintf('                      Smernik [gon]                    \n')
fprintf('-------------------------------------------------------\n')
fprintf(' Stan.   Smer   |     Vysl.      Ze sou�.   |    Odleh.\n')
fprintf('-------------------------------------------------------\n')
for i = 1:size(smerniky,1)
    fprintf('%5.0f\t%5.0f\t|\t%9.4f\t%9.4f\t|\t%7.4f\n',smerniky(i,:))
end
fprintf('=======================================================\n')
