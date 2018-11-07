function [hodnota] = zaradDoKvadrantu(hodnota)
    if(hodnota < 0)         
        while(hodnota < 0)        
            hodnota = hodnota + 2*pi; 
        end
    end
    if(hodnota >= 2*pi)     
        while(hodnota >= 2*pi)  
            hodnota = hodnota - 2*pi; 
        end
    end
end