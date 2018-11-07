function [smery] = excentrickeStanovisko(smery,delky)
% ================
% vstupní hodnoty:
% ----------------
% smery ... [rad] ... osnova vodorovnych smeru
% delky ... [m]   ... delka mezi centrem a bodem (ze souradnic + excentricita)
% =================
% výstupní hodnoty:
% -----------------
% smery ... [rad] ... osnova opravena o centracni zmeny
;
    % 1) najdi smer na centr
    % radek s nejkratsi delkou je smer na excentr
    index = 0;
    dist = inf;
    for i = 1:size(delky,1)
        if(delky(i)<dist)
            dist  = delky(i);
            index = i;
        end
    end
    % 2) vypocet
    epsilon0 = 2*pi - smery(index);
    ee = delky(index);
    for i = 1:size(delky,1)
        if(i ~= index)
            epsilon = smery(i) + epsilon0;
            dalfa = asin(ee*sin(epsilon)/delky(i));
            smery(i) = smery(i) + dalfa;
        else % smer na excentr
            if(smery(i) < pi)
                smery(i) = smery(i) + pi;
            else
                smery(i) = smery(i) - pi;
            end
        end
        smery(i) = zaradDoKvadrantu(smery(i));
    end
end