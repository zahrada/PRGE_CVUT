function [centrovaneSmery] = redukceSmeru(o,souradnice,cil)
;
    % vytvor seznam stanovisek - spojí nekolik po sobe jdoucich radku (není to jako funkce unique)
    stanoviska1 = [o(1,1) 1 1]; % stanovisko zacatek konec bloku
    for j = 2:size(o,1)    
        if(stanoviska1(end,1)~=o(j,1))
            stanoviska1(end,3)   = j - 1;
            stanoviska1(end+1,1) = o(j,1);
            stanoviska1(end,2)   = j;
            stanoviska1(end,3)   = size(o,1);
        end
    end
    centrovaneSmery = [];
    for i = 1:size(stanoviska1,1)    
        psiS11  = 0;SS11  = 0;    
        psiS1C1 = 0;SS1C1 = 0;
        for j = stanoviska1(i,2):stanoviska1(i,3)
            if o(j,2)==0 % centr (1)
                psiS11 = o(j,3)*pi/200; 
                SS11   = o(j,4);
            elseif o(j,2)==1 % excentr (C1)
                psiS1C1 = o(j,3)*pi/200;
                SS1C1   = o(j,4);
            end
        end
        for j = stanoviska1(i,2):stanoviska1(i,3)  
            if (o(j,2)~=0 && o(j,2)~=1) % kdyz cilim na bod kde jsme nemerily -> uloha excentricke stanovisko (cil centricky)
                notmeasured = 1; % nastavime na tomto bode nebylo mereno            
                for k = 1:size(stanoviska1,1)
                    if(o(j,2)==stanoviska1(k,1))
                        notmeasured = 0;
                        break;                    
                    end
                end            
                if notmeasured == 1 % kdyz nebylo mereno                
                    bod1 = stanoviska1(i,1);
                    X1 = souradnice(souradnice(:,1)==bod1,2);
                    Y1 = souradnice(souradnice(:,1)==bod1,3); 
        
                    bod2 = o(j,2);
                    X2 = souradnice(souradnice(:,1)==bod2,2);
                    Y2 = souradnice(souradnice(:,1)==bod2,3);
                
                    S12 = sqrt((X2-X1)^2+(Y2-Y1)^2);
                
                    smery = [psiS11,o(j,3)*pi/200]';
                    delky = [SS11,S12]';
                
                    [smery] = excentrickeStanovisko(smery,delky);
                    dalfa = smery(end) - o(j,3)*pi/200;
                
                    if(cil(souradnice(:,1)==bod2,:)=='C')
                        centrovaneSmery(end+1,1:3) = [bod1,bod2,dalfa*200/pi];
                        centrovaneSmery(end,5:6) = [o(j,3),smery(end)*200/pi];
                    end
                end
            end
        end 
        for j = 1:size(stanoviska1,1)
            if(stanoviska1(j,1)~=stanoviska1(i,1))
            
                bod1 = stanoviska1(i,1);
                X1 = souradnice(souradnice(:,1)==bod1,2);
                Y1 = souradnice(souradnice(:,1)==bod1,3); 
        
                bod2 = stanoviska1(j,1);
                X2 = souradnice(souradnice(:,1)==bod2,2);
                Y2 = souradnice(souradnice(:,1)==bod2,3); 
            
                S12 = sqrt((X2-X1)^2+(Y2-Y1)^2);
                        
                psiS22  = o(find(o(:,1)==bod2 & o(:,2)==0),3)*pi/200;
                psiS2C2 = o(find(o(:,1)==bod2 & o(:,2)==1),3)*pi/200;
                psiS2C1 = o(find(o(:,1)==bod2 & o(:,2)==bod1),3)*pi/200;
                SS22    = o(find(o(:,1)==bod2 & o(:,2)==0),4);
                SS2C2   = o(find(o(:,1)==bod2 & o(:,2)==1),4);            
                psiS1C2 = o(find(o(:,1)==bod1 & o(:,2)==bod2),3)*pi/200;            
            
                [delta] = centracniZmena(psiS11,psiS1C1,psiS1C2,psiS22,psiS2C2,psiS2C1,SS11,SS1C1,SS22,SS2C2,S12);
                psi12 = zaradDoKvadrantu(psiS1C2 + delta);
            
%             [psi12,psi21,dalfa12,dalfa21] = centraceSmeru(psiS11,psiS1C1,psiS1C2,psiS22,psiS2C2,psiS2C1,SS11,SS1C1,SS22,SS2C2,S12);                                  
%             delta = dalfa12;
            
                centrovaneSmery(end+1,1:3) = [bod1,bod2,delta*200/pi];
                centrovaneSmery(end,5:6) = [psiS1C2*200/pi,psi12*200/pi];            
            end
        end
    end
    % smerove korekce;
    for i = 1:size(centrovaneSmery,1)   
        bod1 = centrovaneSmery(i,1);
        bod2 = centrovaneSmery(i,2);  
        X1 = souradnice(souradnice(:,1)==bod1,2);
        Y1 = souradnice(souradnice(:,1)==bod1,3);      
        X2 = souradnice(souradnice(:,1)==bod2,2);
        Y2 = souradnice(souradnice(:,1)==bod2,3);
        [delta12] = redukceSmeruKrovak(X1,Y1,X2,Y2);
        centrovaneSmery(i,4) = delta12*200/pi;    
        centrovaneSmery(i,7) = centrovaneSmery(i,6) + centrovaneSmery(i,4);
    end
end