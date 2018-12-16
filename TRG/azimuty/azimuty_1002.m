clear all;
clc;
format long g

%datum mìøení 30.5.2011
D = datenum(2011, 5, 30);

%zemìpisná šíøka stanoviska
lambda = [16 58 35.733];
lambda_stupne = lambda(1,1) + lambda(1,2)/60 + lambda(1,3)/3600;
lambda_hod = lambda_stupne / 15;
lambda_rad = lambda_hod / 12 * pi;

%zemìpisná délka stanoviska
fi0 = [50 8 43.5491];
fi0_stupne = fi0(1,1) + fi0(1,2)/60 + fi0(1,3)/3600;
fi0_rad = fi0_stupne / 180 * pi;

%Greenwichský hvìzdný èas pro svìtovou pùlnoc
S0 = [16 28 39.475];
S0_hod = S0(1,1) + S0(1,2)/60 + S0(1,3)/3600;

%DUT1
DUT1 = -0.27647 / 3600;

%meridiánová konvergence
c = [-5 53 11.9341];
c_stupne = c(1) - c(2)/60 - c(3)/3600;

%nejbližší nižší rektascenze
alpha0 = [4 26 5.1];
alpha0_hod = alpha0(1,1) + alpha0(1,2)/60 + alpha0(1,3)/3600;

daIm05 = (4/60 + 4.4/3600); %DeltaI -0.5 pro alpha v hodinach
daIp05 = (4/60 + 5.0/3600); %DeltaI +0.5 pro alpha v hodinach
daIp15 = (4/60 + 5.3/3600); %DeltaI +1.5 pro alpha v hodinach

daII0 = daIp05 - daIm05;
daII1 = daIp15 - daIp05;

daII05 = (daII0 + daII1) / 2;

%nejbližší nižší deklinace
delta0 = [21 41 2];
delta0_stupne = delta0(1,1) + delta0(1,2)/60 + delta0(1,3)/3600;

ddIm05 = (9/60 + 18/3600); %DeltaI -0.5 pro delta ve stupnich
ddIp05 = (8/60 + 56/3600); %DeltaI +0.5 pro delta ve stupnich
ddIp15 = (8/60 + 33/3600); %DeltaI +1.5 pro delta ve stupnich

ddII0 = ddIp05 - ddIm05;
ddII1 = ddIp15 - ddIp05;

ddII05 = (ddII0 + ddII1) / 2;

%mìøení Honza

%poèátek pracovního èasu SELÈ
poc_prac_casu = [16 35 0];
mereni = [
% prac.cas		smìr		teplota	tlak
%hod	min	sec	gon		°C	mbar
0	15	48.25	113.3210	22.5	936
0	16	33.60	113.3210	22.5	936
0	17	13.13	112.9861	22.5	936
0	18	 4.50	112.9861	22.5	936
0	23	29.91	111.5447	22.5	936
0	24	22.25	111.5447	22.5	936
0	25	33.47	111.0665	22.5	936
0	26	30.45	111.0665	22.5	936];

mereni_honza = [];
for i = 1 : 2 : rows(mereni)
    cas1 = (mereni(i,1) + mereni(i,2)/60 + mereni(i,3)/3600);
    cas2 = (mereni(i+1,1) + mereni(i+1,2)/60 + mereni(i+1,3)/3600);
    cas = mean([cas1 cas2]);
    utc1 = (poc_prac_casu(1) + poc_prac_casu(2)/60 + poc_prac_casu(3)/3600) + (mereni(i,1) + mereni(i,2)/60 + mereni(i,3)/3600) - 2;
    utc2 = (poc_prac_casu(1) + poc_prac_casu(2)/60 + poc_prac_casu(3)/3600) + (mereni(i+1,1) + mereni(i+1,2)/60 + mereni(i+1,3)/3600) - 2;
    utc = mean([utc1 utc2]);
    tc = utc + 34/3600 + 32.184/3600;

    %interpolace v tabulkách
    n = tc/24;
    alpha_hod = alpha0_hod + (n * daIp05) + ((n*(n-1)*daII05)/2);
    delta_stupne = delta0_stupne + (n * ddIp05) + ((n*(n-1)*ddII05)/2);

    mereni_honza = [mereni_honza; utc mereni(i,4:6) alpha_hod delta_stupne];
end

%mìøení Rada

%poèátek pracovního èasu SELÈ
poc_prac_casu = [16 35 0];
mereni = [
% prac.cas		smìr		teplota	tlak
%hod	min	sec	gon		°C	mbar
0	33	 8.38	109.3831	22.5	936
0	34	 0.25	109.3831	22.5	936
0	34	56.00	109.0029	22.5	936
0	35	38.67	109.0029	22.5	936
0	39	27.88	107.9886	22.5	936
0	40	18.60	107.9886	22.5	936
0	41	15.11	107.5667	22.5	936
0	42	20.51	107.5667	22.5	936];

mereni_rada = [];
for i = 1 : 2 : rows(mereni)
    cas1 = (mereni(i,1) + mereni(i,2)/60 + mereni(i,3)/3600);
    cas2 = (mereni(i+1,1) + mereni(i+1,2)/60 + mereni(i+1,3)/3600);
    cas = mean([cas1 cas2]);
    utc1 = (poc_prac_casu(1) + poc_prac_casu(2)/60 + poc_prac_casu(3)/3600) + (mereni(i,1) + mereni(i,2)/60 + mereni(i,3)/3600) - 2;
    utc2 = (poc_prac_casu(1) + poc_prac_casu(2)/60 + poc_prac_casu(3)/3600) + (mereni(i+1,1) + mereni(i+1,2)/60 + mereni(i+1,3)/3600) - 2;
    utc = mean([utc1 utc2]);
    tc = utc + 34/3600 + 32.184/3600;

    %interpolace v tabulkách
    n = tc/24;
    alpha_hod = alpha0_hod + (n * daIp05) + ((n*(n-1)*daII05)/2);
    delta_stupne = delta0_stupne + (n * ddIp05) + ((n*(n-1)*ddII05)/2);

    mereni_rada = [mereni_rada; utc mereni(i,4:6) alpha_hod delta_stupne];
end

%mìøení Zuzka

%poèátek pracovního èasu SELÈ
poc_prac_casu = [16 35 0];
mereni = [
% prac.cas		smìr		teplota	tlak
%hod	min	sec	gon		°C	mbar
0	 1	57.15	116.5343	22.5	936
0	 3	 5.14	116.5343	22.5	936
0	 4	20.58	116.0008	22.5	936
0	 5	 8.82	116.0008	22.5	936
0	 8	16.85	115.0320	22.5	936
0	 9	25.60	115.0320	22.5	936
0	10	12.41	114.6202	22.5	936
0	10	59.53	114.6202	22.5	936];

mereni_zuzka = [];
for i = 1 : 2 : rows(mereni)
    cas1 = (mereni(i,1) + mereni(i,2)/60 + mereni(i,3)/3600);
    cas2 = (mereni(i+1,1) + mereni(i+1,2)/60 + mereni(i+1,3)/3600);
    cas = mean([cas1 cas2]);
    utc1 = (poc_prac_casu(1) + poc_prac_casu(2)/60 + poc_prac_casu(3)/3600) + (mereni(i,1) + mereni(i,2)/60 + mereni(i,3)/3600) - 2;
    utc2 = (poc_prac_casu(1) + poc_prac_casu(2)/60 + poc_prac_casu(3)/3600) + (mereni(i+1,1) + mereni(i+1,2)/60 + mereni(i+1,3)/3600) - 2;
    utc = mean([utc1 utc2]);
    tc = utc + 34/3600 + 32.184/3600;

    %interpolace v tabulkách
    n = tc/24;
    alpha_hod = alpha0_hod + (n * daIp05) + ((n*(n-1)*daII05)/2);
    delta_stupne = delta0_stupne + (n * ddIp05) + ((n*(n-1)*ddII05)/2);

    mereni_zuzka = [mereni_zuzka; utc mereni(i,4:6) alpha_hod delta_stupne];
end

disp('dilci vysledky')

mereni = [mereni_honza; mereni_rada; mereni_zuzka];
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
sigma_prumer = mean(sigma_vec);
stupne(sigma_prumer  * pi / 180)
sigma_grady = sigma_prumer * 200 / 180

disp('smernik ze souradnic 1002-1004')
sigma_rad = atan2((559774.5 - 560712.5), (1053012.0 - 1058509.0));
sigma_grady = sigma_rad * 200 / pi
stupne(sigma_rad + 2*pi)