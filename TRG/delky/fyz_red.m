function [D_red] = fyz_red(mereni)

alfa = 1/276.16;

t = mean([mereni(5),mereni(7)]);
p = mean(mereni(9:10));
e = mean(mereni(11:12));
D = mereni(13);

deltaD = 280.2096 - 295.8193 * (p/760) * (1/(1+t*alfa)) - ((5.5e-2/(1+t*alfa)) * e);

D_red = D * (1 + deltaD * 1e-6);