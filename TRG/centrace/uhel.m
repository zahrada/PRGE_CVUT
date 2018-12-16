function uhel=uhel(souradnice,leve_rameno,stanovisko,prave_rameno)

bod1 = souradnice(find(souradnice(:,1)==leve_rameno), :);
bod2 = souradnice(find(souradnice(:,1)==stanovisko), :);
bod3 = souradnice(find(souradnice(:,1)==prave_rameno), :);

smernik_levy = smernik(bod2,bod1);
smernik_pravy = smernik(bod2,bod3);

uhel = smernik_pravy - smernik_levy;
if uhel < 0
  uhel += 400;
end



