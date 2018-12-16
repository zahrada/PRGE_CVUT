clear all;
clc;
format long g

%datum mìøení 30.5.2011
D = datenum(2011, 5, 30);

%zemìpisná šíøka stanoviska
lambda = [16 58 54.3531];
lambda_stupne = lambda(1,1) + lambda(1,2)/60 + lambda(1,3)/3600;
lambda_hod = lambda_stupne / 15;
lambda_rad = lambda_hod / 12 * pi;

%zemìpisná délka stanoviska
fi0 = [50 11 43.6471];
fi0_stupne = fi0(1,1) + fi0(1,2)/60 + fi0(1,3)/3600;
fi0_rad = fi0_stupne / 180 * pi;

%Greenwichský hvìzdný èas pro svìtovou pùlnoc
S0 = [16 28 39.475];
S0_hod = S0(1,1) + S0(1,2)/60 + S0(1,3)/3600;

%DUT1
DUT1 = -0.27647 / 3600;

%meridiánová konvergence
c = [-5 52 56.6846];
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


%mìøení

mereni = [
% prac.cas		smìr		teplota	tlak
%hod	min	sec	gon		°C	mbar
16	20	20.0	339.9344		21	921.3
16	27	20.0	338.1843		21	921.3
16	37	55.0	335.6169		21	921.3
16	43	55.0	334.1937		21	921.3
16	51	12.5	332.4919		21	921.3
16	56	15.0	331.3367		21	921.3
17	02	15.0	329.9703		21	921.3
17	06	05.0	329.1078		21	921.3
17	09	22.5	328.3865		21	921.3
17	12	27.5	327.6896		21	921.3
17	16	17.5	326.8529		21	921.3
17	20	05.0	326.0218		21	921.3];

mereni_1004 = [];
for i = 1 : rows(mereni)
    utc = (mereni(i,1) + mereni(i,2)/60 + mereni(i,3)/3600) - 2;
    tc = utc + 34/3600 + 32.184/3600;

    %interpolace v tabulkách
    n = tc/24;
    alpha_hod = alpha0_hod + (n * daIp05) + ((n*(n-1)*daII05)/2);
    delta_stupne = delta0_stupne + (n * ddIp05) + ((n*(n-1)*ddII05)/2);

    mereni_1004 = [mereni_1004; utc mereni(i,4:6) alpha_hod delta_stupne];
end

disp('dilci vysledky')

mereni = mereni_1004;
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

disp('smernik ze souradnic 1004-1003')
sigma_rad = atan2((560933.5 - 559774.5), (1055292.5 - 1053012.0));
sigma_grady = sigma_rad * 200 / pi
stupne(sigma_rad)


