function [delta] = centracniZmena(psiS11,psiS1C1,psiS1C2,psiS22,psiS2C2,psiS2C1,SS11,SS1C1,SS22,SS2C2,S12)
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
% delta ... [rad] ... centracni zmena
;
    % 0.iterace
    % osnova na stanovisku 1
    es1 = SS11;
    ec1 = SS1C1;
    %bod S1
    om_S1_TR1 = psiS11-psiS1C2;
    if om_S1_TR1<0
        om_S1_TR1 = om_S1_TR1+2*pi;
    end
    sig_S1_TR1 = 0+om_S1_TR1;

    sig_TR1_S1 = sig_S1_TR1+pi;
    if sig_TR1_S1<0
        sig_TR1_S1 = sig_TR1_S1+2*pi;
    elseif sig_TR1_S1>2*pi
        sig_TR1_S1 = sig_TR1_S1-2*pi;        
    end
    XS1 = es1*cos(sig_TR1_S1);
    YS1 = es1*sin(sig_TR1_S1);
    %bod c1
    om_S1_C1 = psiS1C1-psiS11;
    if om_S1_C1<0
        om_S1_C1 = om_S1_C1+2*pi;
    end
    sig_S1_C1 = sig_S1_TR1+om_S1_C1;
    XC1 = XS1+ec1*cos(sig_S1_C1);
    YC1 = YS1+ec1*sin(sig_S1_C1);
    % osnova na stanovisku 2
    es2 = SS22;
    ec2 = SS2C2;
    %bod S2
    om_S2_TR2 = psiS22-psiS2C1;

    if om_S2_TR2<0
        om_S2_TR2 = om_S2_TR2+2*pi;
    end
    sig_S2_TR2 = pi+om_S2_TR2;

    sig_TR2_S2 = sig_S2_TR2+pi;
    if sig_TR2_S2<0
        sig_TR2_S2 = sig_TR2_S2+2*pi;
    elseif sig_TR1_S1>2*pi
        sig_TR2_S2 = sig_TR2_S2-2*pi;        
    end
    XS2 = S12+es2*cos(sig_TR2_S2);
    YS2 = es2*sin(sig_TR2_S2);
    %bod C2
    om_S2_C2 = psiS2C2-psiS22;
    if om_S2_C2<0
        om_S2_C2 = om_S2_C2+2*pi;
    end
    sig_S2_C2 = sig_S2_TR2+om_S2_C2;
    XC2 = XS2+ec2*cos(sig_S2_C2);
    YC2 = YS2+ec2*sin(sig_S2_C2);
    % iteracni vypocet
    sig_S1_C2 = 0;
    sig_S1_C2_old = 1;
    sig_S2_C1 = pi;
    sig_S2_C1_old = 1;
    i = 0;
    while abs(sig_S1_C2_old-sig_S1_C2)>1e-5/(200/pi) || abs(sig_S2_C1_old-sig_S2_C1)>1e-5/(200/pi) % zacatek iteracniho cyklu 
        i = i+1;
        % osnova 1 - urceni smerniku S1-C2
        sig_S1_C2_old = sig_S1_C2;
        sig_S1_C2 = atan2(YC2-YS1,XC2-XS1);
        if sig_S1_C2<0
            sig_S1_C2 = sig_S1_C2+2*pi;
        end
        %bod S1
        sig_S1_TR1 = sig_S1_C2+om_S1_TR1;

        sig_TR1_S1 = sig_S1_TR1+pi;
        if sig_TR1_S1<0
            sig_TR1_S1 = sig_TR1_S1+2*pi;
        elseif sig_TR1_S1>2*pi
            sig_TR1_S1 = sig_TR1_S1-2*pi;        
        end
        XS1 = es1*cos(sig_TR1_S1);
        YS1 = es1*sin(sig_TR1_S1);
        %bod c1
        sig_S1_C1 = sig_S1_TR1+om_S1_C1;
        XC1 = XS1+ec1*cos(sig_S1_C1);
        YC1 = YS1+ec1*sin(sig_S1_C1);
        % osnova 2 - urceni smerniku S2-C1
        sig_S2_C1_old = sig_S2_C1;
        sig_S2_C1 = atan2(YC1-YS2,XC1-XS2);
        if sig_S2_C1<0
            sig_S2_C1 = sig_S2_C1+2*pi;
        end
        %bod S2
        sig_S2_TR2 = sig_S2_C1+om_S2_TR2;
        sig_TR2_S2 = sig_S2_TR2+pi;
        if sig_TR2_S2<0
            sig_TR2_S2 = sig_TR2_S2+2*pi;
        elseif sig_TR1_S1>2*pi
            sig_TR2_S2 = sig_TR2_S2-2*pi;        
        end

        XS2 = S12+es2*cos(sig_TR2_S2);
        YS2 = es2*sin(sig_TR2_S2);
        %bod C2
        sig_S2_C2 = sig_S2_TR2+om_S2_C2;
        XC2 = XS2+ec2*cos(sig_S2_C2);
        YC2 = YS2+ec2*sin(sig_S2_C2);
    end % konec iteracniho cyklu
    sig_C1_C2 = atan2(YC2-YC1,XC2-XC1);
    if sig_C1_C2<0
        sig_C1_C2 = sig_C1_C2+2*pi;
    end
    kontrola = sig_C1_C2*(200/pi);
    sig_S1_C2 = atan2(YC2-YS1,XC2-XS1);
    delta = -sig_S1_C2;
end

