clear all;
clc;
format long g

%datum mìøení 30.5.2011
D = datenum(2011, 5, 30);

%zemìpisná šíøka stanoviska
lambda = [16 58 8.028];
lambda_stupne = lambda(1,1) + lambda(1,2)/60 + lambda(1,3)/3600;
lambda_hod = lambda_stupne / 15;
lambda_rad = lambda_hod / 12 * pi;

%zemìpisná délka stanoviska
fi0 = [50 10 26.3754];
fi0_stupne = fi0(1,1) + fi0(1,2)/60 + fi0(1,3)/3600;
fi0_rad = fi0_stupne / 180 * pi;

%Greenwichský hvìzdný èas pro svìtovou pùlnoc
S0 = [16 32 36.032];
S0_hod = S0(1,1) + S0(1,2)/60 + S0(1,3)/3600;

%DUT1
DUT1 = -0.27647 / 3600;

%meridiánová konvergence
c = [-5 53 32.2935];
c_stupne = c(1) - c(2)/60 - c(3)/3600;

%nejbližší nižší rektascenze
alpha0 = [4 30 10.1];
alpha0_hod = alpha0(1,1) + alpha0(1,2)/60 + alpha0(1,3)/3600;

daIm05 = (4/60 + 5.0/3600); %DeltaI -0.5 pro alpha v hodinach
daIp05 = (4/60 + 5.3/3600); %DeltaI +0.5 pro alpha v hodinach
daIp15 = (4/60 + 5.8/3600); %DeltaI +1.5 pro alpha v hodinach

daII0 = daIp05 - daIm05;
daII1 = daIp15 - daIp05;

daII05 = (daII0 + daII1) / 2;

%nejbližší nižší deklinace
delta0 = [21 49 58];
delta0_stupne = delta0(1,1) + delta0(1,2)/60 + delta0(1,3)/3600;

ddIm05 = (8/60 + 56/3600); %DeltaI -0.5 pro delta ve stupnich
ddIp05 = (8/60 + 33/3600); %DeltaI +0.5 pro delta ve stupnich
ddIp15 = (8/60 + 11/3600); %DeltaI +1.5 pro delta ve stupnich

ddII0 = ddIp05 - ddIm05;
ddII1 = ddIp15 - ddIp05;

ddII05 = (ddII0 + ddII1) / 2;


%mìøení

mereni = [
% prac.cas		smìr		teplota	tlak
%hod	min	sec	gon		°C	mbar
15	59	13.5	145.2854		21.5	920
16	01	27.5	144.6979		21.5	920
16	04	20  	143.9116		21.5	920
16	10	12.5	142.3787		21.5	920
16	14	47.5	141.1900		21.5	920
16	16	19  	140.8135		21.5	920
16	19	11  	140.0752		21.5	920
16	20	27.5	139.7566		21.5	920
16	26	02.5	138.3594		21.5	920
16	27	22.5	138.0367		21.5	920
16	30	05  	137.3704		21.5	920
16	31	27.5	137.0356		21.5	920
];	
  	
mereni_1003 = [];
for i = 1 : rows(mereni)
    utc = (mereni(i,1) + mereni(i,2)/60 + mereni(i,3)/3600) - 2;
    tc = utc + 34/3600 + 32.184/3600;

    %interpolace v tabulkách
    n = tc/24;
    alpha_hod = alpha0_hod + (n * daIp05) + ((n*(n-1)*daII05)/2);
    delta_stupne = delta0_stupne + (n * ddIp05) + ((n*(n-1)*ddII05)/2);

    mereni_1003 = [mereni_1003; utc mereni(i,4:6) alpha_hod delta_stupne];
end

disp('dilci vysledky')

mereni = mereni_1003;
%hlavní výpoèetní cyklus
for i = 1 : rows(mereni)
  %èas mìøení
  utc_hod = mereni(i,1);
  %vodorovný úhel
  omega_grady = mereni(i,2);
  omega_stupne = omega_grady * 180 / 200;
  %rektascenze
  alpha_hod = mereni(i,5);
  %deklinace
  delta_stupne = mereni(i,6);
  delta_rad = delta_stupne * pi/180;
  %teplota
  teplota = mereni(i,3);
  %tlak
  tlak = mereni(i,4);
  %hodinový úhel
  t_hod = S0_hod + ((utc_hod + DUT1) * 1.0027379093) - alpha_hod + lambda_hod;
  mereni(i,10) = t_hod;
  t_rad = t_hod * pi / 12;
  %azimut slunce
  a_rad = atan((sin(t_rad)*cos(delta_rad))/(sin(fi0_rad)*cos(delta_rad)*cos(t_rad) - cos(fi0_rad)*sin(delta_rad)));
  a_stupne = a_rad * 180 / pi;
  mereni(i,7) = a_rad * 200 / pi;
  %zenitová vzdálenost
  z_rad = asin(sin(t_rad)*cos(delta_rad)/sin(a_rad));
  %denní aberace
  aberace = -0.32 * cos(fi0_rad) * cos(a_rad) * csc(z_rad); %oprava je ve vteøinách
  a_stupne += aberace / 3600;
  mereni(i,8) = aberace / 3600 * 200 / 180;
  A_stupne = a_stupne + omega_stupne;
  mereni(i,11) = A_stupne * 200 / 180;
  mereni(i,9) = omega_stupne * 200 / 180;
  sigma = A_stupne - c_stupne + 10/3600;
  mereni(i,12) = sigma * 200 / 180;
  stupne(sigma * pi / 180)
  sigma_vec(i) = sigma;
end
mereni

disp('prumer')
sigma_prumer = mean(sigma_vec(1:12));
stupne(sigma_prumer  * pi / 180)
sigma_grady = sigma_prumer * 200 / 180

disp('smernik ze souradnic 1003-1004')
sigma_rad = atan2((559774.5 - 560933.5), (1053012.0 - 1055292.5));
sigma_grady = sigma_rad * 200 / pi
stupne(sigma_rad + 2*pi)
