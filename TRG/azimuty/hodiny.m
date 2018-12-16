function hodiny(radiany)
a=radiany * 12 /pi;
stupne=fix(a);
b=(a-stupne)*60;
minuty=fix(b);
vteriny=(b-minuty)*60;
disp([num2str(stupne) '°' num2str(minuty) '´' num2str(vteriny,5) '"'])
