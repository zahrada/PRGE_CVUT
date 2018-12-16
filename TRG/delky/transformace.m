function [X_ETRF,Y_ETRF,Z_ETRF,X_JTSK_rov,Y_JTSK_rov] = transformace(B0,L0,H0,hT)

%elipsoidické souøadnice bodu v ETRF
B_ETRF = (B0(1) + B0(2)/60 + B0(3)/3600) * pi/180;
L_ETRF = (L0(1) + L0(2)/60 + L0(3)/3600) * pi/180;
Hel_ETRF = H0 + hT;

%konstanty elipsoidu GRS80
a_GRS = 6378137.0; %m
e2_GRS = 0.006694380022901;

%pravoúhlé souøadnice bodu v ETRF
N_ETRF = a_GRS/(sqrt(1 - (e2_GRS * (sin(B_ETRF))^2)));
X_ETRF = (N_ETRF+Hel_ETRF) * cos(B_ETRF) * cos(L_ETRF);
Y_ETRF = (N_ETRF+Hel_ETRF) * cos(B_ETRF) * sin(L_ETRF);
Z_ETRF = (N_ETRF*(1-e2_GRS)+Hel_ETRF) * sin(B_ETRF);

%transformace provoúhlých souøadnic ETRF -> JTSK
vec_ETRF = [X_ETRF Y_ETRF Z_ETRF]';

t1 = -572.203;
t2 =  -85.328;
t3 = -461.934;
T = [t1 t2 t3]';

m4 = -3.5393e-6;
q = 1+m4;

r5 = (5.24832714 / 3600) * (pi/180);
r6 = (1.52900087 / 3600) * (pi/180);
r7 = (4.97311727 / 3600) * (pi/180);
R = [	1 	r5	-r6
	-r5	1	r7
	r6	-r7	1];

vec_JTSK = T + q * R * vec_ETRF;

%pravoúhlé souøadnice bodu v JTSK
X_JTSK = vec_JTSK(1);
Y_JTSK = vec_JTSK(2);
Z_JTSK = vec_JTSK(3);

%konstanty Besselova elipsoidu
a_Bess = 6377397.155; %m
e2_Bess = 0.00667437223062;

%elipsoidické souøadnice bodu v JTSK
%elipsoidická délka
L_JTSK = atan2(Y_JTSK,X_JTSK);
%pomocná substituce
P = sqrt(X_JTSK^2 + Y_JTSK^2);

%0-tá iterace šíøky, polomìru køivosti, výšky
B_JTSK_i = atan((Z_JTSK/P) * (1/(1 - e2_Bess)));
N_JTSK = a_Bess/(sqrt(1 - (e2_Bess * (sin(B_JTSK_i))^2)));
Hel_JTSK_i = (P/cos(B_JTSK_i)) - N_JTSK;
Hel_JTSK = 0;
B_JTSK = 0;

%iteraèní výpoèet šíøky, polomìru køivosti, výšky
while ((abs(Hel_JTSK_i - Hel_JTSK) > 0.0001) || (abs(B_JTSK_i - B_JTSK) > ((0.00001 / 3600) * (pi/180))))
  Hel_JTSK = Hel_JTSK_i;
  B_JTSK = B_JTSK_i;
  B_JTSK_i = atan((Z_JTSK/P) * (1/(1 - (N_JTSK/(N_JTSK+Hel_JTSK))*e2_Bess)));
  N_JTSK = a_Bess/(sqrt(1 - (e2_Bess * (sin(B_JTSK))^2)));
  Hel_JTSK_i = (P/cos(B_JTSK_i)) - N_JTSK;
end

B_JTSK = B_JTSK_i;
Hel_JTSK = Hel_JTSK_i;

%Modifikováné køovákovo zobrazení
%Pøevod z Greenwiche na Ferro
L_Ferro = L_JTSK + ((17 + 40/60) * pi/180);

%konstanty
fi_0 = (49 + 30/60) * pi/180;
alpha =  sqrt(1 + ((e2_Bess * (cos(fi_0))^4)/(1 - e2_Bess)));
U_Q = (59 + 42/60 + 42.69689/3600) * pi/180;
U_0 = asin((sin(fi_0))/alpha);
e_Bess = sqrt(e2_Bess);
g_fi_0 = ((1 + e_Bess * sin(fi_0))/(1 - e_Bess * sin(fi_0)))^(alpha * e_Bess / 2);
k = tan(U_0 / 2 + (45 * pi/180)) * (cot(fi_0 / 2 + (45 * pi/180)))^(alpha) * g_fi_0;
k_1 = 0.9999;
N_0 = (a_Bess * sqrt(1 - e2_Bess)) / (1 - e2_Bess * (sin(fi_0))^2);
S_0 = (78 + 30/60) * pi/180;
n = sin(S_0);
rho_0 = k_1 * N_0 * cot(S_0);

%transformace B,L -> U,V
g_B = ((1 + e_Bess * sin(B_JTSK)) / (1 - e_Bess * sin(B_JTSK)))^(alpha * e_Bess / 2);
U = 2*(atan(k * (tan(B_JTSK / 2 + (45 * pi/180)))^(alpha) * g_B^(-1)) - (45 * pi/180));
deltaV = alpha * ((42 + 30/60) * pi/180 - L_Ferro);
a_cara = 90 * pi/180 - U_Q;

%transformace U,V -> S,D
S = asin(cos(a_cara) * sin(U) + sin(a_cara) * cos(U) * cos(deltaV));
D = asin((cos(U) * sin(deltaV)) / cos(S));

%transformace S,D -> rho,epsilon
epsilon = n * D;
rho = rho_0 * (tan(S_0 / 2  + (45 * pi/180)))^n * (cot(S / 2  + (45 * pi/180)))^n;

%pøibližné roinné souøadnice
X_cara = rho * cos(epsilon);
Y_cara = rho * sin(epsilon);

X_red = X_cara - 1089000.0;
Y_red = Y_cara - 654000.0;

A1  =  0.2946529277e-01;
A2  =  0.2515965696e-01;
A3  =  0.1193845912e-06;
A4  = -0.4668270147e-06;
A5  =  0.9233980362e-11;
A6  =  0.1523735715e-11;
A7  =  0.1696780024e-17;
A8  =  0.4408314235e-17;
A9  = -0.8331083518e-23;
A10 = -0.3689471323e-23;

delta = [A1; A2] + [A3, -A4; A4, A3] * [X_red; Y_red] + [A5, -A6; A6, A5] * [(X_red^2 - Y_red^2); (2 * X_red * Y_red)] + [A7, -A8; A8, A7] * [(X_red * (X_red^2 - 3 * Y_red^2)); (Y_red * (3 * X_red^2 - Y_red^2))] + [A9, A10; -A10, A9] * [(4 * Y_red * X_red * (X_red^2 - Y_red^2)); (X_red^2  + Y_red^2 - 6 * X_red^2 * Y_red^2)];

deltaX = delta(1);
deltaY = delta(2);

X_JTSK05 = (X_cara - deltaX) + 5000000;
Y_JTSK05 = (Y_cara - deltaY) + 5000000;

[dX, dY] = interpolace((X_cara - deltaX),(Y_cara - deltaY));

X_JTSK_rov = X_JTSK05 - 5000000 - dX;
Y_JTSK_rov = Y_JTSK05 - 5000000 - dY;