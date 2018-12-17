clc
clear all
format long g
%% zadani
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

o = [
% den1_7_1001_2.txt
1001 0          20.5617  6.867    %# orientacni osnova (posledni udaj: vod. delka opravena o souctovou konstantu minihranolu) 
1001 1          0.0000   4.806    %# orientacni osnova (posledni udaj: vod. delka opravena o souctovou konstantu minihranolu)
1001 1002       89.8642  0       %   # orientacni osnova !!!!!!!!!!!
1001 1003       53.2671  0        %  # orientacni osnova 
1001 1004       30.2735  0        %  # orientacni osnova 

% den1_7_1002_2.txt % dve stanoviska na jendom bode to nedava
1002 1          16.3576   4.737    % # orientacni osnova (posledni udaj: vod. delka)
1002 0          127.2205  6.180    % # orientacni osnova (posledni udaj: vod. delka)
1002 1001       0.0000    0        %# orientacni osnova 
1002 1003       60.1813   0       % # orientacni osnova
1002 1004       75.2950   0        % # orientacni osnova
% % den1_6_1002_1.txt.txt
% 1002 0          95.6767  3.572  %   # orientacni osnova (posledni udaj: vod. delka)
% 1002 1          393.2087 7.102   %  # orientacni osnova (posledni udaj: vod. delka)
% 1002 1001        0.0000  0     %     # orientacni osnova
% 1002 1003       60.1333	 0	 %# orientacni osnova
% 1002 1004       75.2738  0     %     # orientacni osnova
%den1_1_1003_2.txt
1003 1          391.5348  4.545     %# orientacni osnova (posledni udaj: vod. delka - mìøeno pásmem)
1003 0          26.0180   6.299     %# orientacni osnova (posledni udaj: vod. delka - mìøeno na miniHRANOL Leica)
1003 1001       103.0592  0          %# orientacni osnova
1003 1002       0.0000    0         %# orientacni osnova
1003 1004       234.2683  0          %# orientacni osnova
% den1_1_1004_2.txt
1004 0          32.7153  6.979     %# orientacni osnova (posledni udaj: vod. delka) Pozn.: minihranol Leica
1004 1          41.8323  4.010     %# orientacni osnova (posledni udaj: vod. delka) Pozn.: pasmo
1004 1001       64.9939  0          %# orientacni osnova 
1004 1002       0.0000   0        % # orientacni osnova
1004 1003       19.0285  0         % # orientacni osnova

% %den2_45_1001_1.txt
% 1001 0        317.3774   6.472  % # orientacni osnova (posledni udaj: vod. delka)24.0498 
% 1001 1        293.3276   7.448  % # orientacni osnova (posledni udaj: vod. delka)0.0000
% 1001 1002      59.6514   0   %      # orientacni osnova 166.3238 
% 1001 1003      23.0018   0    %     # orientacni osnova 129.6742 
% 1001 1004      0.00000   0     %    # orientacni osnova 106.6724
% 
% %den2_45_1002_2.txt
% 1002 0          32.8682   6.703   %  # orientacni osnova (posledni udaj: vod. delka)
% 1002 1          0.0000    13.534   % # orientacni osnova (posledni udaj: vod. delka)
% 1002 1001       9.4463    0       % # orientacni osnova
% 1002 1003       69.4816   0       %  # orientacni osnova 
% 1002 1004       84.6634   0      %   # orientacni osnova 
% %den2_45_1003_2.txt
% 1003 0          16.8302   5.5855  %  # orientacni osnova (posledni udaj: vod. delka)
% 1003 1          73.0797   4.8915   % # orientacni osnova (posledni udaj: vod. delka)
% 1003 1001       316.7416  0          %# orientacni osnova
% 1003 1002       213.4750  0         % # orientacni osnova
% 1003 1004       47.7183   0        % # orientacni osnova
% 1003 1005       300.5628  0          %# orientacni osnova
% %den2_45_1004_2.txt % A jeste s
% %èárkou místo teèky
% 1004 0           97.2151  4.270     %# orientacni osnova (posledni udaj: vod. delka)
% 1004 1          144.3946  4.280     %# orientacni osnova 
% 1004 1001        65.0389  0		     %# orientacni osnova (posledni udaj: vod. delka)
% 1004 1002         0.0000  0         % # orientacni osnova
% 1004 1003        19.0833  0          %# orientacni osnova

% % den3_2_1001_1.txt
% 1001 0          310.9620  3.406     %# orientacni osnova (posledni udaj: vod. delka) Pozn.: minihranol Leica    merena 3.423
% 1001 1          274.3113  2.758     %# orientacni osnova (posledni udaj: vod. delka) Pozn.: pasmo
% 1001 1002       59.6496   0         %# orientacni osnova 
% 1001 1003       23.0158   0         %# orientacni osnova
% 1001 1004        0.0000   0        % # orientacni osnova
% % den3_3_1002_1.txt
% 1002 0          142.9770  4.3499     %# orientacni osnova (posledni udaj: vod. delka)
% 1002 1          385.7461  4.5187    %# orientacni osnova (posledni udaj: vod. delka)
% 1002 1001         0.0000  0		    %# orientacni osnova 
% 1002 1003        60.1793  0         % # orientacni osnova
% 1002 1004        75.3049  0          %# orientacni osnova
% % den3_3_1003_1.txt
% 1003 0            119.2801  9.850   %# orientacni osnova (posledni udaj: vod. delka)
% 1003 1            102.8593  5.708   %# orientacni osnova (posledni udaj: vod. delka)
% 1003 1001         103.0326  0        %# orientacni osnova
% 1003 1002         0.0000    0       % # orientacni osnova
% 1003 1004         233.8754	0	    %# orientacni osnova 
% 1003 1005         86.8716   0        %# orientacni osnova
% % den3_2_1004_1.txt
% 1004 0           81.4224   2.502    % # orientacni osnova (posledni udaj: vod. delka)
% 1004 1           164.3112  2.618    % # orientacni osnova (posledni udaj: vod. delka)
% 1004 1001        65.0464   0        % # orientacni osnova 
% 1004 1002         0.0000   0       %  # orientacni osnova
% 1004 1003        19.0548   0        % # orientacni osnova

];
u = [
    % den1_7_1001_2.txt
1001 1004 1003   22.9911   22.9915   22.9919
1001 1003 1002   36.5960   36.5970   36.5970
1001 1004 1002   59.5894   59.5880   58.5886
% % den1_6_1002_1.txt.txt
% 1002 1001 1003   60.1334   60.1337   60.1327
% 1002 1003 1004   15.1405   15.1399   15.1405 
% 1002 1001 1004   75.2734   75.2734   75.2737 
   % den1_1_1003_2.txt
1003 1002 1001   103.0587  103.0596  103.0590
1003 1001 1004   131.2120  131.2118  131.2117 
1003 1002 1004   234.2706  234.2699  234.2712 
% den1_1_1004_2.txt
1004 1002 1001   64.9954   64.9960   64.9952
1004 1003 1001   45.9636   45.9644   45.9645 
1004 1002 1003   19.0298   19.0298	 19.0288

% den1_7_1002_2.txt % dve stanoviska na jendom bode to nedava
1002 1001 1003   60.1798   60.1792   60.1791
1002 1003 1004   15.1107   15.1095   15.1103 
1002 1001 1004   75.2893   75.2893   75.2893

% %den2_45_1001_1.txt
% 1001 1002 1003   36.6502   36.6495   36.6493
% 1001 1003 1004   23.0011   23.0022   23.0029 
% 1001 1002 1004   59.6528   59.6519   59.6534         
% %den2_45_1002_2.txt
% 1002 1001 1003   60.0353   60.0338   60.0334
% 1002 1001 1004   75.2173   75.2170   75.2163 
% 1002 1003 1004   15.1814   15.1822   15.1817      
% %den2_45_1003_2.txt
% 1003 1004 1002   165.7581   165.7577   165.7583
% 1003 1001 1004   131.9753   131.9761   131.9758 
% 1003 1002 1005    87.0856    87.0861    87.0856
% 1003 1005 1001    16.1806    16.1816    16.1806
% %den2_45_1004_2.txt % PROBLEM S CISLAMA CILU !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% 1004 1002 1003   19.0830	19.0832	  19.0838
% 1004 1003 1001   45.9547	45.9556	  45.9553 
% 1004 1002 1001   65.0391	65.0394	  65.0394 


% %den3_2_1001_1.txt
% 1001 1004 1003   23.0156   23.0154   23.0174 
% 1001 1003 1002   36.6356   36.6356	  36.6362 
% 1001 1004 1002   59.6520   59.6508   59.6507
% % den3_3_1002_1.txt
% 1002 1001 1003   60.1768   60.1776   60.1777
% 1002 1003 1004   15.1271   15.1248   15.1255 
% 1002 1001 1004   75.3053   75.1960	 75.3029
% % den3_3_1003_1.txt
% 1003 1002 1005   86.8729   86.8717   86.8703
% 1003 1005 1001   16.1628   16.1622   16.1623
% 1003 1001 1004   130.8414  130.8437   130.8423
% 1003 1004 1002   166.1226  166.1225   166.1224
% % den3_2_1004_1.txt
% 1004 1002 1001   65.0449   65.0453   65.0464
% 1004 1002 1003   19.0550   19.0548   19.0553 
% 1004 1003 1001   45.9899   45.9899   45.9904  
];

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
%% redukce uhlu
centrovaneUhly = [];
for(i = 1:size(u,1))        
    [u(i,1) u(i,2) u(i,3)];
    % najdi levou centracni zmenu
    lneni = 1;
    lzmena = 0;
    lkor = 0;
    for(j = 1:size(centrovaneSmery,1))
        if(u(i,1)==centrovaneSmery(j,1) && u(i,2)==centrovaneSmery(j,2))
            lzmena = centrovaneSmery(j,3);
            lkor = centrovaneSmery(j,4);
            lneni = 0;
            break;
        end
    end
    % najdi pravou centracni zmenu
    pneni = 1;
    pzmena = 0;
    pkor = 0;
    for(j = 1:size(centrovaneSmery,1))
        if(u(i,1)==centrovaneSmery(j,1) && u(i,3)==centrovaneSmery(j,2))
            pzmena = centrovaneSmery(j,3);
            pkor = centrovaneSmery(j,4);
            pneni = 0;
            break;
        end
    end
    if(lneni==1)
        fprintf('L Smer z %1.0f na %1.0f nebyl nalezen (centracni zmena je nastavena na nulu)! Pridejte osnovu na bode %1.0f.\n',u(i,1),u(i,2),u(i,2));
    end
    if(pneni==1)
        fprintf('P Smer z %1.0f na %1.0f nebyl nalezen (centracni zmena je nastavena na nulu)! Pridejte osnovu na bode %1.0f.\n',u(i,1),u(i,3),u(i,3));
    end
    
    sumOmCentr = 0;
    countOmCentr = 0;
    for(j = 4:size(u,2))
        if(u(i,j)~=-1)
            sumOmCentr = sumOmCentr + u(i,j);
            countOmCentr = countOmCentr + 1;
        end
    end
    omCentr = sumOmCentr/countOmCentr + pzmena - lzmena;
    omKor   = omCentr + pkor - lkor;
    
    bod1 = u(i,1);
    bod2 = u(i,2);  
    bod3 = u(i,3);
    X1 = souradnice(souradnice(:,1)==bod1,2);
    Y1 = souradnice(souradnice(:,1)==bod1,3);      
    X2 = souradnice(souradnice(:,1)==bod2,2);
    Y2 = souradnice(souradnice(:,1)==bod2,3);
    X3 = souradnice(souradnice(:,1)==bod3,2);
    Y3 = souradnice(souradnice(:,1)==bod3,3);
    
    smkL = atan2(X2-X1,Y2-Y1);
    smkP = atan2(X3-X1,Y3-Y1);
    mabyt = zaradDoKvadrantu(smkL - smkP);
    delta = omKor*pi/200 - mabyt;
    
    centrovaneUhly(end+1,:) = [u(i,1:3) lzmena pzmena lkor pkor mean([u(i,4:6)]) omCentr omKor delta*200/pi];
end
fprintf('===============================================================================================================\n')
fprintf('                                               Redukce uhlu [gon]                                              \n')
fprintf('---------------------------------------------------------------------------------------------------------------\n')
fprintf(' Stan.   Leve   Prave   |    ZmenaL  ZmenaP   KorL    KorP  |     OmPrum       OmRed       OmKor    |   Odleh. \n')
fprintf('---------------------------------------------------------------------------------------------------------------\n')
for(i = 1:size(centrovaneUhly,1))
    fprintf('%5.0f\t%5.0f\t%5.0f\t|\t%7.4f\t%7.4f\t%7.4f\t%7.4f\t|\t%9.4f\t%9.4f\t%9.4f\t|\t%7.4f\n',centrovaneUhly(i,:)) 
end
fprintf('===============================================================================================================\n')