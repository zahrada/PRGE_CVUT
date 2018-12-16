function smernik=smernik(souradnice,stanovisko,cil)

  bod1 = souradnice(find(souradnice(:,1)==stanovisko), 2:3);
  bod2 = souradnice(find(souradnice(:,1)==cil), 2:3);

  smernik = atan2(bod2(2) - bod1(2), bod2(1) - bod1(1));
  if smernik < 0
    smernik += 2*pi;
  end

