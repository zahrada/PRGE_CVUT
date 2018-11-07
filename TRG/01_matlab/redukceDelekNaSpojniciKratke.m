function [Dred,delta] = redukceDelekNaSpojniciKratke(SD,ZEN,H,vs,vc,R)
% ================
% vstupn� hodnoty:
% ----------------
% SD  ... [m]   ... sikma delka
% ZEN ... [rad] ... zenitov� �hel
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
    % u vypoctu stredoveho uhlu nen� jasn� zdali d�vat do �itatele
    % sikmou/vodorovnou a dale pro jak dlouhe delky lze vubec tento vzorec
    % pouzit (pro jiny vzorec je treba znat nadmorskou vysku pro koncovych bodu)
    fi = SD/(R+H); % vzorec je pouze priblizny - urcen pro kratke vzdalenosti
    Dred = sqrt(SD*SD + dv*dv - 2*SD*dv*cos(ZEN - fi)) - fi*vs; 
    delta = Dred - SD;
end