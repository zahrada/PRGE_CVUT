function [psi,delka] = excentrickyCil(psi,smery,delky)
% ================
% vstupní hodnoty:
% ----------------
% psi   ... [rad] ... smer na excentricky cil
% smery ... [rad] ... osnova vodorovnych smeru na excentrickem cili
% delky ... [m]   ... delky na excentrickem cili
% poznamka: smery a delky by meli byt dva (na centr a na stanovisko)
% =================
% výstupní hodnoty:
% -----------------
% psi   ... [rad] ... smer na centricky cil
% delka ... [m]   ... delka na centricky cil
;
    delka = 0;
    % 1) najdi smer na centr
    % radek s nejkratsi delkou je smer na excentr
    index = 0;
    dist = inf;
    for i = 1:length(delky)
        if(delky(i)<dist)
            dist  = delky(i);
            index = i;
        end
    end
    % 2) vypocet
    ee = delky(index);
    for i = 1:length(delky)
        if(i ~= index)
            % merene epsilon
            epsilon2 = smery(i) - smery(index);            
            
            % prvni priblizeni
            dalfa = 0;
            epsilon2 = zaradDoKvadrantu(epsilon2);
            if(epsilon2 > pi)
                epsilon = epsilon2 - pi - dalfa;
            else
                epsilon = epsilon2 + pi + dalfa;
            end
            dalfa = asin(ee*sin(epsilon)/delky(i));
             
            % do dvou metru muzeme prerusit
            if(ee < 2)
               psi = psi + dalfa; 
               psi = zaradDoKvadrantu(psi);               
               if(epsilon2 < pi)
                   delka = sqrt(ee*ee + delky(i)*delky(i) - ee*delky(i)*cos(epsilon2));
               else
                   delka = sqrt(ee*ee + delky(i)*delky(i) - ee*delky(i)*cos(4*pi - epsilon));
               end
               break; 
            end
            
            % druhe priblizeni
            epsilon = zaradDoKvadrantu(epsilon);
            epsilon*200/pi
            if(epsilon > pi)
                epsilon = epsilon - pi - dalfa;
            else
                epsilon = epsilon + pi - dalfa;
            end
            dalfa = asin(ee*sin(epsilon)/delky(i));
            
            % vysledek
            psi = psi + dalfa;
            psi = zaradDoKvadrantu(psi);
           
            if(epsilon2 < pi)
                delka = sqrt(ee*ee + delka(i)*delka(i) - ee*delka(i)*cos(epsilon2));
            else
                delka = sqrt(ee*ee + delka(i)*delka(i) - ee*delka(i)*cos(4*pi - epsilon));
            end
        end
    end
end