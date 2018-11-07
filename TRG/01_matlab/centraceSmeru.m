function[psi12,psi21,dalfa12,dalfa21] = centraceSmeru(psiS11,psiS1C1,psiS1C2,psiS22,psiS2C2,psiS2C1,SS11,SS1C1,SS22,SS2C2,S12)
% ================
% vstupní hodnoty:
% ----------------
% psiS11,psiS1C1,psiS1C2 ... [rad] ... smery na stanovisku S1
% psiS22,psiS2C2,psiS2C1 ... [rad] ... smery na stanovisku S2
% SS11,SS1C1             ... [m]   ... delky na stanovisku S1
% SS22,SS2C2             ... [m]   ... delky na stanovisku S2
% S12                    ... [m]   ... delka mezi centrickymi stanovisky
% =================
% výstupní hodnoty:
% -----------------
% psi12,psi21     ... [rad] ... centrovane smery
% dalfa12,dalfa21 ... [rad] ... centracni zmeny
;
    sigS2C1     = pi;
    sigS1C2     = 0;
    sigS2C1_tmp = 0;
    X1 = 0;
    Y1 = 0;
    X2 = S12;
    Y2 = 0;
    i = 0;
    while(abs(sigS2C1 - sigS2C1_tmp) > 1e-9)
        i = i + 1;
        sigS2C1_tmp = sigS2C1; 
        betta = psiS1C2 - psiS11;
        if(betta <= 0)
            betta = betta + 2*pi;
        end
        if(betta > 2*pi)
            betta = betta - 2*pi;
        end
        if(betta <= pi/2 && betta > 0)
            XS1 = -SS11*cos(betta - sigS1C2);
            YS1 =  SS11*sin(betta - sigS1C2);
        elseif(betta > pi/2 && betta <= pi)
            XS1 = SS11*sin(psiS1C2 - psiS11 - sigS1C2 - pi/2);
            YS1 = SS11*cos(psiS1C2 - psiS11 - sigS1C2 - pi/2);
        elseif(betta > pi && betta <= 3*pi/2)
            XS1 =  SS11*sin(2*pi - betta + sigS1C2 - pi/2);
            YS1 = -SS11*cos(2*pi - betta + sigS1C2 - pi/2);
        elseif(betta > 3*pi/2 && betta <= 2*pi)
            XS1 = -SS11*cos(2*pi - betta + sigS1C2);
            YS1 = -SS11*sin(2*pi - betta + sigS1C2);
        end
        sigS11 = atan2(Y1 - YS1,X1 - XS1);
        if(sigS11 < 0)
            sigS11 = sigS11 + 2*pi;
        end
        XC1 = XS1 + SS1C1*cos(sigS11 + psiS1C1 - psiS11);
        YC1 = YS1 + SS1C1*sin(sigS11 + psiS1C1 - psiS11);
        gamma = psiS2C1 - psiS22;
        if(gamma < 0)
            gamma = gamma + 2*pi;
        end
        XS2 = S12 - SS22*cos(sigS2C1 - psiS2C1 + psiS22);
        YS2 =       SS22*sin(sigS2C1 - psiS2C1 - psiS22);
        if(gamma > 3*pi/2)
            XS2 = S12 + SS22*sin(gamma - sigS2C1 - pi/2);
            YS2 =       SS22*cos(gamma - sigS2C1 - pi/2);
        end
        sigS22 = atan2(Y2 - YS2,X2 - XS2);
        XC2 = XS2 + SS2C2*cos(sigS22 + psiS2C2 - psiS22);
        YC2 = YS2 + SS2C2*sin(sigS22 + psiS2C2 - psiS22);
        sigS1C2 = atan2(YC2 - YS1,XC2 - XS1);
        sigS2C1 = atan2(YC1 - YS2,XC1 - XS2);
        if(sigS2C1 < 0)
            sigS2C1 = sigS2C1 + 2*pi;
        end
        if(sigS2C1 > 2*pi)
            sigS2C1 = sigS2C1 - 2*pi;
        end
        if(i > 1e7)
            disp('Number of loops exceeds limit!');
            break;
        end
    end
    % centracni zmeny
    dalfa12 = -atan2(YC2 - YS1,XC2 - XS1);  % smk1C2 - smk12        
    dalfa21 = atan2(YC1 - YS2,XC1 - XS2) - pi; % smk2C1 - smk21 
    % smery na centrickych stanoviscich
    psi12 = psiS1C2 + dalfa12;
    psi21 = psiS2C1 + dalfa21;
    % zarazeni do spravnych kvadrantu
    dalfa12 = zaradDoKvadrantu(dalfa12);    
    if(dalfa12 < pi)
        dalfa12 = zaradDoKvadrantu(dalfa12);
    else
        dalfa12 = 2*pi-zaradDoKvadrantu(dalfa12);
    end    
    dalfa21 =  zaradDoKvadrantu(dalfa21);
    if(dalfa21 < pi)
        dalfa21 = zaradDoKvadrantu(dalfa21);
    else
        dalfa21 = 2*pi-zaradDoKvadrantu(dalfa21);
    end
    psi12 = zaradDoKvadrantu(psi12);
    psi21 = zaradDoKvadrantu(psi21);
end