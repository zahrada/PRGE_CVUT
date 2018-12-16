function oprava_krovak=oprava_krovak(souradnice,stanovisko,cil)

  X1 = souradnice(find(souradnice(:,1)==stanovisko), 3);
  Y1 = souradnice(find(souradnice(:,1)==stanovisko), 2);
  X2 = souradnice(find(souradnice(:,1)==cil), 3);
  Y2 = souradnice(find(souradnice(:,1)==cil), 2);

  R0 = 1298039.0046;
  
  R1 = sqrt(X1^2 + Y1^2);
  D1 = atan2(Y1, X1);

  R2 = sqrt(X2^2 + Y2^2);
  D2 = atan2(Y2, X2);

  dR1 = R1 - R0;
  dR2 = R2 - R0;

  K1 = 5.3145e-9 * dR1 + 2.045e-15 * dR1^2;
  K2 = 5.3145e-9 * dR2 + 2.045e-15 * dR2^2;

  delta12 = (D2 - D1) * (3600 * 180 / pi) * (2 * K1 * (R2 / R1) + K2 * (R1 / R2));
  oprava_krovak = (delta12 / 3600) * (200 / 180);