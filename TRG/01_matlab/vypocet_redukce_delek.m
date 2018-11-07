clc
clear all 
format long g
%% redukce delek - zadani
% souradnice = [ % priblizne
%     1001	1055371.3	565726.4	835.35
%     1002	1058509.0	560712.3	702.23
%     1003	1055295.5	560932.6	732.23
%     1004	1053013.0	559764.8	913.90
%     1005	1055720.5	562455.4	558.36
% ];

souradnice = [ % z GNSS
    1001 1055371.3414 565726.3933 835.3539
    1002 1058508.9963 560712.3111 702.2396
    1003 1055295.4952 560932.5703 732.2303
    1004 1053013.0242 559764.7797 913.9033
    1005 1055720.5267 562455.4135 558.3680
    ];



d = [
    % C.b1  C.b2    hT[m]   hc[m]   t1[°C]   t2[°C]   p1[]     p2[]     h1[%]  h2[%]   d[m]
    % Lukeš kontrola
    1001  1003  1.664   1.485   15   15   21  21    697   700   57   57   4795.849
    % ------- 1.turnus -------
%	den1_1_1003_2
	1003	1002	1.548	1.578	11.3	7.4     11.5	7.0     718     721     0	0	3221.357	
	1003	1001	1.548	1.448	11.3	7.4     10.0	0       718     0       0	0	4795.825
	1003	1004	1.548	1.550	11.3	7.4     10.5	7.0     718     702     0	0	2570.487
	1003	1002	1.548	1.578	11.7	7.5     13.1	8.5     714     720     0	0	3221.350
	1003	1001	1.548	1.448	11.7	7.5     10.0	0       714     0       0	0	4795.817
	1003	1004	1.548	1.550	11.7	7.5     10.0	6.5     714     700     0	0	2570.478
%	den1_1_1004_2
	1004	1003	1.58	1.505	12.5	8.5     11.3	7.4     700.5	715.5	0	0	2570.495
	1004	1002	1.58	1.578	10.5	7.0     13.1	8.5     699.0	720.0	0	0	5581.472
	1004	1003	1.58	1.505	10.5	7.0     12.4	8.1     699.0	715.0	0	0	2570.490
%	den1_6_1002_1
	1002	1004	1.595	1.550	12.2	7.6     10.0	7.0     580     561     53	66	5581.527
	1002	1001	1.595	1.448	12.2	7.6     11.9	0       580     0       53	0	5916.901
	1002	1003	1.595	1.505	12.2	8.9     10.6	7.1     583     576     65	61	3221.432
%	den1_7_1001_2
	1001	1002	1.475	1.578	11.9	12.1    0       7.6     0.0     720     0.0 53   5916.901
	1001	1003	1.475	1.505	11.9	12.1    0       8.9     0.0     715     0.0 66   4795.896
	1001	1004	1.475	1.580	11.9	9.0     0       6.0     0.0     699     0.0 64   6412.194
	1001	1002	1.475	1.578	12.1	12.2    0       7.6     0.0     720     0.0 53   5916.894
	1001	1003	1.475	1.505	12.1	12.1    0       8.9     0.0     715     0.0 66   4795.892
	1001	1004	1.475	1.580	12.1	10.0    0       7.0     0.0     701     0.0 66   6412.197
    %	-------	3.turnus	-------
%	den3_2_1001_1.txt
	1001	1003	1.565	1.525	19.5	16.0	19.0	17.0	695.5	704.0	70	82	4794.759	%#merena	4794.761
	1001	1002	1.565	1.334	19.5	16.0	16.5	14.0	695.5	718.0	70	76	5915.291	%#merena	5915.293
	1001	1003	1.565	1.525	17.0	12.5	21.0	17.5	695.0	704.0	60	71	4794.741	%#merena	4794.743
	1001	1002	1.565	1.334	17.0	12.5	20.5	16.0	695.0	717.0	60	64	5915.286	%#merena	5915.288
%	den3_2_1004_1.txt
	1004	1002	1.568	1.334	13.0	16.5	09.5	12.5	0       708     68	69	5581.438
	1004	1003	1.568	1.525	12.5	16.5	13.5	14.5	0       705     64	90	2570.459
	1004	1003	1.568	1.525	15.0	18.0	18.0	21.0	0       704     73	75	2570.453
	1004	1002	1.568	1.334	15.0	18.0	13.5	18.0	0       717     73	61	5581.420
%	den3_3_1002_1.txt
	1002	1004	1.334	1.540	9.5     12.5	11.0	15.0	709     0       69	61	5581.5039
	1002	1003	1.334	1.525	9.5     12.5	12.0	15.0	709     705     69	71	3221.4103
	1002	1004	1.334	1.540	14.5	18.5	15.0	18.0	707     0       65	73	5581.4725
	1002	1001	1.334	1.550	14.5	18.5	13.0	15.5	707     696     65	76	5916.8390
	1002	1003	1.334	1.525	14.5	18.5	17.0	19.5	707     704     65	70	3221.3820
%	den3_3_1003_1.txt
	1003	1002	1.525	1.334	12.0	14.5	9.0     11.5	708     708     73	68	3221.388
	1003	1001	1.525	1.550	12.0	14.5	11.5	14.0	69      695.5	73	75	4795.885
	1003	1004	1.525	1.540	12.0	14.5	11.0	15.0	698     0       73	61	2570.471
	1003	1002	1.525	1.334	16.0	19.0	14.0	16.5	697     718     74	76	3221.369
	1003	1001	1.525	1.540	16.0	19.0	13.0	15.5	697     696     74	76	4795.873
	1003	1004	1.525	1.540	16.0	19.0	13.5	17.5	698     0       74	65	2570.465
	%	-------	2.turnus	-------
%	den2_45_1001_1.txt
 	1001	1002	1.651	1.480	14      11      12      8.5     702     709.5	0.00    0.00	5916.817
 	1001	1003	1.651	1.390	14      11      19      0       702     834     0.00	0.00	4795.867
 	1001	1003	1.651	1.390	17      13      25.3	0       701.5	700     0.00	0.00	4795.852
 	1001	1002	1.651	1.480	17      13      17.5	12.5	701.5	708.8	0.00	0.00	5916.797
% %	den2_45_1002_1.txt
% 	1002	1001	1.480	1.630	12.0	8.5     13.0	9.0     576	562	5916.902
% 	1002	1003	1.480	1.390	12.0	8.5     16.0	576     0	3221.421	%#p2	=	946	hPa	
% 	1002	1004	1.480	1.520	12.0	8.5     10.0	7.5     576	559	5581.527
% 	1002	1001	1.480	1.630	17.5	12.5	20.0	16.0	575	561	5916.868
% 	1002	1003	1.480	1.390	17.5	12.5	25      575	0	3221.405	%#p2	=	945	hPa	
% 	1002	1004	1.480	1.520	17.5	12.5	17.5	13.0	575	559	5581.498
% %	den2_45_1002_2.txt
 	1002	1001	1.480	1.630	12.0	8.5     13.0	9.0     716     702     0       0       5916.902
 	1002	1003	1.480	1.390	12.0	8.5     16.0    0       716     709.6	0       0       3221.421	
 	1002	1004	1.480	1.520	12.0	8.5     10.0	7.5     716     699     0       0       5581.527
 	1002	1001	1.480	1.630	17.5	12.5	20.0	16.0	715     701     0       0       5916.868
 	1002	1003	1.480	1.390	17.5	12.5	25      715     709     0       0       0       3221.405	
 	1002	1004	1.480	1.520	17.5	12.5	17.5	13.0	715     699     0       0       5581.498
% %	den2_45_1002_3.txt
% 	1002	1001	1.500	1.630	12.0	8.5	13.0	9.0	716	702	0	0	5916.902
% 	1002	1003	1.500	1.390	12.0	8.5	16.0	716	709.6	0	0	3221.421	
% 	1002	1004	1.500	1.520	12.0	8.5	10.0	7.5	716	699	0	0	5581.527
% 	1002	1001	1.500	1.630	17.5	12.5	20.0	16.0	715	701	0	0	5916.868
% 	1002	1003	1.500	1.390	17.5	12.5	25	715	709	0	0	3221.405	
% 	1002	1004	1.500	1.520	17.5	12.5	17.5	13.0	715	699	0	0	5581.498
% %	den2_45_1003_1.txt
% 	1003	1002	1.416	1.480	19.1	19.1	12.0	8.5	709.6	576	0	0	3221.363
% 	1003	1001	1.416	1.630	22.5	22.5	15.0	12.0	709.6	562	0	0	4795.874
% 	1003	1004	1.416	1.540	19.0	19.0	13.5	9.5	709.6	559	0	0	2570.455
% 	1003	1001	1.414	1.630	21.0	21.0	20.0	16.0	708.8	561.5	0	0	4795.864
% 	1003	1002	1.414	1.480	21.0	21.0	17.5	12.5	708.8	575	0	0	3221.357
% 	1003	1004	1.414	1.540	21.0	21.0	17.5	13.0	708.8	558.5	0	0	2570.454
% %	den2_45_1003_2.txt
 	1003	1002	1.416	1.480	19.1	19.1	12.0	8.5     709     716     0       0       3221.363
    1003	1001	1.416	1.630	22.5	22.5	15.0	12.0	709     702     0       0       4795.874
 	1003	1004	1.416	1.540	19.0	19.0	13.5	9.5     709     699 	0       0       2570.455
    1003	1001	1.414	1.630	21.0	21.0	20.0	16.0	708     701     0       0       4795.864
 	1003	1002	1.414	1.480	21.0	21.0	17.5	12.5	708     715     0       0       3221.357
 	1003	1004	1.414	1.540	21.0	21.0	17.5	13.0	708     699     0       0       2570.454
%	den2_45_1004_1.txt
%	1004	1002	1.54	1.48	13.5	9.5	12.0	8.5	559	576				5581.517
%	1004	1003	1.54	1.39	13.5	9.5	20.3	559	0					2570.506		%#	p2=946.0	[hPa]	
%	1004	1002	1.54	1.48	17.5	13.0	17.5	12.5	558.5	575					5581.508
%	1004	1003	1.54	1.39	17.5	13.0	25.0		558.5	0					2570.501	%#	p2=945.2	[hPa]
%	den2_45_1004_2.txt
	1004	1002	1.54	1.48	13.5	9.5     12.0	8.5     699     716		0		0       5581.517
	1004	1003	1.54	1.39	13.5	9.5     20.3    0       699     709.6	0   	0       2570.506		
	1004	1002	1.54	1.48	17.5	13.0	17.5	12.5	698.5	715		0		0       5581.508
	1004	1003	1.54	1.39	17.5	13.0	25.0    0       698.5	709		0		0       2570.501	
];

%% redukce delek - vypocet
redukceDelekVysledky = [];
k = 0.13;
R = 6380000;
for i = 1:size(d,1)    
    Dmer = d(i,13);
    t1 = mean([d(i,5),d(i,6)]);
    p1 = d(i,9);
    h1 = d(i,11);
    
    t2 = mean([d(i,7),d(i,8)]);
    p2 = d(i,10);
    h2 = d(i,12);
    
    hT1 = d(i,3);
    hT2 = d(i,4);
        
%     if(t1 ~= 0 && t2~= 0 && p1 ~= 0 && p2 ~= 0 && h1 ~= 0 && h2 ~= 0 && hT1 ~= 0 && hT2 ~= 0)
    if(hT1 ~= 0 && hT2 ~= 0)
        bod1 = d(i,1);
        bod2 = d(i,2);
        
        X1_JTSK = souradnice(souradnice(:,1)==bod1,2);
        Y1_JTSK = souradnice(souradnice(:,1)==bod1,3);
    
        X2_JTSK = souradnice(souradnice(:,1)==bod2,2);
        Y2_JTSK = souradnice(souradnice(:,1)==bod2,3);
    
        H1_Bessel = souradnice(souradnice(:,1)==bod1,4);
        H2_Bessel = souradnice(souradnice(:,1)==bod2,4);   

        Dsour = sqrt((X2_JTSK-X1_JTSK)^2+(Y2_JTSK-Y1_JTSK)^2);
        
        [Dfyz,delta1] = fyzikalniRedukce(Dmer,t1,t2,p1,p2,h1,h2);
        [Dmat,delta2] = matematickeRedukceJtsk(Dfyz,X1_JTSK,Y1_JTSK,H1_Bessel,X2_JTSK,Y2_JTSK,H2_Bessel,hT1,hT2,R,k);
        redukceDelekVysledky(end+1,:) = [bod1,bod2,Dmer,Dfyz,Dmat,Dsour,delta1,delta2];
    end
end
% prohodit 1. a 2. sloupec
for i = 1:size(redukceDelekVysledky,1)
    if redukceDelekVysledky(i,2) < redukceDelekVysledky(i,1)
        prvni = redukceDelekVysledky(i,1);
        redukceDelekVysledky(i,1) = redukceDelekVysledky(i,2);
        redukceDelekVysledky(i,2) = prvni;
    end
end
% pripravim si tabulku pro prumery
redukceDelekPrumery = [];
for i = 1:size(souradnice,1)    
    for j = 1:size(souradnice,1)
        if(souradnice(j,1) > souradnice(i,1))
            redukceDelekPrumery(end+1,:) = [souradnice(i,1),souradnice(j,1) 0 0 0];            
        end
    end
end
% pocitam prumery
for i = 1:size(redukceDelekPrumery,1)
    for j = 1:size(redukceDelekVysledky,1)
        if(redukceDelekPrumery(i,1)==redukceDelekVysledky(j,1) && ...
           redukceDelekPrumery(i,2)==redukceDelekVysledky(j,2))
            redukceDelekPrumery(i,3) = redukceDelekPrumery(i,3) + redukceDelekVysledky(j,5);
            redukceDelekPrumery(i,4) = redukceDelekPrumery(i,4) + 1;
            redukceDelekPrumery(i,5) = redukceDelekPrumery(i,3)/redukceDelekPrumery(i,4);
        end
    end    
end
% pocitam odlehlost od prumeru a od hodnoty ze souradnic
for i = 1:size(redukceDelekPrumery,1)
    for j = 1:size(redukceDelekVysledky,1)
        if(redukceDelekPrumery(i,1)==redukceDelekVysledky(j,1) && ...
           redukceDelekPrumery(i,2)==redukceDelekVysledky(j,2))
            redukceDelekVysledky(j,9) = redukceDelekVysledky(j,5) - redukceDelekPrumery(i,5);
        end        
    end
    bod1 = redukceDelekPrumery(i,1);
    bod2 = redukceDelekPrumery(i,2);
    
    X1_JTSK = souradnice(souradnice(:,1)==bod1,2);
    Y1_JTSK = souradnice(souradnice(:,1)==bod1,3);
    
    X2_JTSK = souradnice(souradnice(:,1)==bod2,2);
    Y2_JTSK = souradnice(souradnice(:,1)==bod2,3);  

    redukceDelekPrumery(i,6) = sqrt((X2_JTSK-X1_JTSK)^2+(Y2_JTSK-Y1_JTSK)^2);
end
redukceDelekPrumery(:,7)   = redukceDelekPrumery(:,5) - redukceDelekPrumery(:,6);
redukceDelekVysledky(:,10) = redukceDelekVysledky(:,5) - redukceDelekVysledky(:,6);
%% redukce delek - vysledky
fprintf('======================================================================================================\n')
fprintf('                                           Redukce delek [m]                                          \n')
fprintf('------------------------------------------------------------------------------------------------------\n')
fprintf('  CB      CB    |    Dmer        Dfyz        Dmat        Dsour      |    (4-3)   (5-4)   (6-5)  odleh.\n')
fprintf('------------------------------------------------------------------------------------------------------\n')
for i = 1:size(redukceDelekVysledky,1)
	fprintf('%5.0f\t%5.0f\t|\t%5.3f\t%5.3f\t%5.3f\t%5.3f\t|\t%6.3f\t%6.3f\t%6.3f\t%6.3f\n',redukceDelekVysledky(i,:))
end
fprintf('------------------------------------------------------------------------------------------------------\n')
fprintf(' max(abs)       |                                                   |   %6.3f\t%6.3f\t%6.3f\t%6.3f\n',max(abs(redukceDelekVysledky(:,7:10))))
fprintf('------------------------------------------------------------------------------------------------------\n')
fprintf('  CB      CB    |    suma       pocet     prumer      Dsour      odleh.    \n')
fprintf('------------------------------------------------------------------------\n')
for i = 1:size(redukceDelekPrumery,1)
    if(redukceDelekPrumery(i,4)~=0)
        fprintf('%5.0f\t%5.0f\t|\t%9.3f\t%5.0f\t%9.3f\t%9.3f\t%6.3f\n',redukceDelekPrumery(i,:))
    end
end
fprintf('========================================================================\n')
% vypocet sm. odchylek
% size(redukceDelekPrumery)
% 
% 
% redukceDelekPrumery(:,8:9) = 0;
% for(i = 1:size(redukceDelekVysledky,1))
%     for(j = 1:size(redukceDelekPrumery,1))
%         if(redukceDelekVysledky(i,1)==redukceDelekPrumery(j,1) && ... 
%            redukceDelekVysledky(i,2)==redukceDelekPrumery(j,2) && redukceDelekPrumery(j,4)~=0)
%             
%             redukceDelekVysledky(i,11) = redukceDelekVysledky(i,6) - redukceDelekPrumery(j,5); % v
%             redukceDelekVysledky(i,12) = (redukceDelekVysledky(i,6) - redukceDelekPrumery(j,5))^2; % vv
%             redukceDelekPrumery(j,8)   = redukceDelekPrumery(j,8) + (redukceDelekVysledky(i,6) - redukceDelekPrumery(j,5))^2;% suma vv
%             redukceDelekPrumery(j,9)   = sqrt(redukceDelekPrumery(j,8)/(redukceDelekPrumery(j,4)-1));
%         end
%     end
% end
% 
% [redukceDelekVysledky(:,1) redukceDelekVysledky(:,2) redukceDelekVysledky(:,11)*100]
% max(abs(redukceDelekVysledky(:,end-1)))
% redukceDelekPrumery;




