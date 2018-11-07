function [delta12] = redukceSmeruKrovak(X1,Y1,X2,Y2)
% ================
% vstupní hodnoty:
% ----------------
% X1,Y1 ... [m] ... souøadnice stanoviska
% X2,Y2 ... [m] ... souøadnice stanoviska
% =================
% výstupní hodnoty:
% -----------------
% delta12 ... [rad] ... smerova korekce z bodu 1 na bod 2
;
   R0 = 1298039.0046;
  
   R1 = sqrt(X1^2+Y1^2);
   D1 = atan2(Y1,X1);

   R2 = sqrt(X2^2+Y2^2);
   D2 = atan2(Y2,X2);

   dR1 = R1 - R0;
   dR2 = R2 - R0;

   K1 = 5.3145e-9*dR1 + 2.045e-15*dR1^2;
   K2 = 5.3145e-9*dR2 + 2.045e-15*dR2^2;

   delta12 = (D2 - D1)*(2*K1*(R2/R1) + K2*(R1/R2)); % v radianech
end