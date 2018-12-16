function [delta]=centracni_zmena(bod1,bod2)

%==========================================================================================================
%|                                             Naètení dat                                                |
%==========================================================================================================

osnovy

switch bod1
  case 1001
    osnova_S1 = osnova_1001;
  case 1002
    osnova_S1 = osnova_1002;
  case 1003
    osnova_S1 = osnova_1003;
  case 1004
    osnova_S1 = osnova_1004;
  case 1005
    osnova_S1 = osnova_1005;
end

switch bod2
  case 1001
    osnova_S2 = osnova_1001;
  case 1002
    osnova_S2 = osnova_1002;
  case 1003
    osnova_S2 = osnova_1003;
  case 1004
    osnova_S2 = osnova_1004;
  case 1005
    osnova_S2 = osnova_1005;
end

%centraèní prvky na S1
c2 = bod2;
c1 = bod1 + 1000;
t1 = bod1;
psi_c2 = osnova_S1(find(osnova_S1(:,1)==c2),2);
psi_t1 = osnova_S1(find(osnova_S1(:,1)==t1),2);
psi_c1 = osnova_S1(find(osnova_S1(:,1)==c1),2);
e_s1t1 = osnova_S1(find(osnova_S1(:,1)==t1),3); %excentricita mezi trigasem1 a S1 (vodorovna)
e_s1c1 = osnova_S1(find(osnova_S1(:,1)==c1),3); %excentricita mezi C1 a S1 (vodorovna)
s_t1t2 = osnova_S1(find(osnova_S1(:,1)==c2),3); %vzdálenost trigasù

omega_t1s1c2 = (psi_c2 - psi_t1) * pi/200; %úhel na S1 mezi trigasem1 a C2 (psi C2 - psi trigas1)
omega_c1s1t1 = (psi_t1 - psi_c1) * pi/200; %úhel na S1 mezi C1 a trigasem1 (psi trigas1 - psi C1)

%centraèní prvky na S2
c2 = bod2 + 1000;
c1 = bod1;
t2 = bod2;
psi_c2 = osnova_S2(find(osnova_S2(:,1)==c2),2);
psi_t2 = osnova_S2(find(osnova_S2(:,1)==t2),2);
psi_c1 = osnova_S2(find(osnova_S2(:,1)==c1),2);
e_s2t2 = osnova_S2(find(osnova_S2(:,1)==t2),3); %excentricita mezi trigasem2 a S2 (vodorovna)
e_s2c2 = osnova_S2(find(osnova_S2(:,1)==c2),3); %excentricita mezi C1 a S1 (vodorovna)

omega_c1s2t2 = (psi_t2 - psi_c1) * pi/200; %úhel na S2 mezi trigasem2 a C1 (psi trigas2 - psi C1)
omega_c2s2t2 = (psi_t2 - psi_c2) * pi/200; %úhel na S2 mezi C2 a trigasem2 (psi trigas2 - psi C2)

%==========================================================================================================
%|                                            0-tá iterace                                                |
%==========================================================================================================

%souradnice S1
sigma_s1c2 = 0 * pi/200;

sigma_s1t1 = sigma_s1c2 - omega_t1s1c2;
sigma_t1s1 = sigma_s1t1 + pi;
if sigma_t1s1 > 2*pi
  sigma_t1s1 -= 2*pi;
end

x_s1 = e_s1t1 * cos(sigma_t1s1);
y_s1 = e_s1t1 * sin(sigma_t1s1);

%souradnice C1
sigma_s1c1 = sigma_s1t1 - omega_c1s1t1;

x_c1 = x_s1 + (e_s1c1 * cos(sigma_s1c1));
y_c1 = y_s1 + (e_s1c1 * sin(sigma_s1c1));

%souradnice S2
sigma_s2c1 = 200 * pi/200;

sigma_s2t2 = sigma_s2c1 + omega_c1s2t2;
sigma_t2s2 = sigma_s2t2 + pi;
if sigma_t1s1 > 2*pi
  sigma_t1s1 -= 2*pi;
end

x_s2 = s_t1t2 + (e_s2t2 * cos(sigma_t2s2));
y_s2 = e_s2t2 * sin(sigma_t2s2);

%souradnice C2
sigma_s2c2 = sigma_s2t2 - omega_c2s2t2;

x_c2 = x_s2 + (e_s2c2 * cos(sigma_s2c2));
y_c2 = y_s2 + (e_s2c2 * sin(sigma_s2c2));

%==========================================================================================================
%|                                           další iterace                                                |
%==========================================================================================================

sigma_s1c2_old = 0;
sigma_s2c1_old = 0;

while ((abs(sigma_s1c2_old-sigma_s1c2)) > (0.00001*pi/200) || (abs(sigma_s2c1_old-sigma_s2c1)) > (0.00001*pi/200))
  sigma_s1c2_old = sigma_s1c2;
  sigma_s2c1_old = sigma_s2c1;

  %souradnice S1
  sigma_s1c2 = atan2(y_c2 - y_s1, x_c2 - x_s1);

  sigma_s1t1 = sigma_s1c2 - omega_t1s1c2;
  sigma_t1s1 = sigma_s1t1 + pi;
  if sigma_t1s1 > 2*pi
    sigma_t1s1 -= 2*pi;
  end

  x_s1 = e_s1t1 * cos(sigma_t1s1);
  y_s1 = e_s1t1 * sin(sigma_t1s1);

  %souradnice C1
  sigma_s1c1 = sigma_s1t1 - omega_c1s1t1;

  x_c1 = x_s1 + (e_s1c1 * cos(sigma_s1c1));
  y_c1 = y_s1 + (e_s1c1 * sin(sigma_s1c1));

  %souradnice S2
  sigma_s2c1 = atan2(y_c1 - y_s2, x_c1 - x_s2);

  sigma_s2t2 = sigma_s2c1 + omega_c1s2t2;
  sigma_t2s2 = sigma_s2t2 + pi;
  if sigma_t1s1 > 2*pi
    sigma_t1s1 -= 2*pi;
  end

  x_s2 = s_t1t2 + (e_s2t2 * cos(sigma_t2s2));
  y_s2 = e_s2t2 * sin(sigma_t2s2);

  %souradnice C2
  sigma_s2c2 = sigma_s2t2 - omega_c2s2t2;

  x_c2 = x_s2 + (e_s2c2 * cos(sigma_s2c2));
  y_c2 = y_s2 + (e_s2c2 * sin(sigma_s2c2));
end

%==========================================================================================================
%|                                          centraèní zmìna                                               |
%==========================================================================================================

sigma_s1c2 = atan2(y_c2 - y_s1, x_c2 - x_s1);
delta = sigma_s1c2  * 200 / pi;

