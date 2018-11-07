function [Dred,delta] = redukceDelekNaSpojniciDlouhe(SD,hs,hc,vs,vc,R)
% ================
% vstupn� hodnoty:
% ----------------
% SD  ... [m]   ... sikma delka
% hs  ... [m]   ... nadmorska vyska stanoviska
% hc  ... [m]   ... nadmorska vyska cile
% vs  ... [m]   ... vyska stroje
% vc  ... [m]   ... vyska cile
% R   ... [m]   ... polomer nahradni koule
% =================
% v�stupn� hodnoty:
% -----------------
% Dred  ... [m] ... redukovan� d�lka
% delta ... [m] ... vliv redukce na spojnici stabiliza�n�ch zna�ek
;
    dv = abs(vs - vc);
    fi = sqrt((SD*SD-((hs+vs)-(hc+vc))*((hs+vs)-(hc+vc)))/((R+hs+vs)*(R+hc+vc)));
    Dred = sqrt(SD*SD + dv*dv - 2*SD*dv*cos(ZEN - fi)) - fi*vs; 
    delta = Dred - SD;
end