function [Dfyz,delta] = fyzikalniRedukce(Dmer,t1,t2,p1,p2,h1,h2)
% ================
% vstupní hodnoty:
% ----------------
% Dmer  ... [m]    ... merena delka (opravena pouze o konstantu hranolu)
% t1,t2 ... [°C]   ... teplota sucha/vlhka
% p1,p2 ... [torr] ... tlak
% h1,h2 ... [%]    ... vlhkost vzduchu
% =================
% výstupní hodnoty:
% -----------------
% Dfyz  ... [m] ... delka opravena o vliv fizikalni korekce
% delta ... [m] ... vliv fyzikalni korekce
;
    t = mean([t1,t2]);
    p = mean([p1,p2]);
    h = mean([h1,h2]);
    alfa = 1/276.16;
    deltaD = 280.2096 - 295.8193*(p/760)*(1/(1+t*alfa)) - ((5.5e-2/(1+t*alfa))*h);
    Dfyz = Dmer*(1 + deltaD*1e-6);
    delta = Dfyz - Dmer;
end