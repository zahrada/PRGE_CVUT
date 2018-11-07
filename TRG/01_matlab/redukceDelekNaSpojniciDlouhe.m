function [Dred,delta] = redukceDelekNaSpojniciDlouhe(SD,hs,hc,vs,vc,R)
% ================
% vstupní hodnoty:
% ----------------
% SD  ... [m]   ... sikma delka
% hs  ... [m]   ... nadmorska vyska stanoviska
% hc  ... [m]   ... nadmorska vyska cile
% vs  ... [m]   ... vyska stroje
% vc  ... [m]   ... vyska cile
% R   ... [m]   ... polomer nahradni koule
% =================
% výstupní hodnoty:
% -----------------
% Dred  ... [m] ... redukovaná délka
% delta ... [m] ... vliv redukce na spojnici stabilizaèních znaèek
;
    dv = abs(vs - vc);
    fi = sqrt((SD*SD-((hs+vs)-(hc+vc))*((hs+vs)-(hc+vc)))/((R+hs+vs)*(R+hc+vc)));
    Dred = sqrt(SD*SD + dv*dv - 2*SD*dv*cos(ZEN - fi)) - fi*vs; 
    delta = Dred - SD;
end