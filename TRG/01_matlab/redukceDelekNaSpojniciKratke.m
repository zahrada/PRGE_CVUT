function [Dred,delta] = redukceDelekNaSpojniciKratke(SD,ZEN,H,vs,vc,R)
% ================
% vstupní hodnoty:
% ----------------
% SD  ... [m]   ... sikma delka
% ZEN ... [rad] ... zenitový úhel
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
    % u vypoctu stredoveho uhlu není jasné zdali dávat do èitatele
    % sikmou/vodorovnou a dale pro jak dlouhe delky lze vubec tento vzorec
    % pouzit (pro jiny vzorec je treba znat nadmorskou vysku pro koncovych bodu)
    fi = SD/(R+H); % vzorec je pouze priblizny - urcen pro kratke vzdalenosti
    Dred = sqrt(SD*SD + dv*dv - 2*SD*dv*cos(ZEN - fi)) - fi*vs; 
    delta = Dred - SD;
end