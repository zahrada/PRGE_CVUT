function smernik=smernik(stanovisko,cil)

  smernik = atan2(cil(2) - stanovisko(2), cil(3) - stanovisko(3)) * 200 / pi;
  if smernik < 0
    smernik += 400;
  end

