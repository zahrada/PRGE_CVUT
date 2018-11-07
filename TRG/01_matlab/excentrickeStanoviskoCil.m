% function [psic1_s1,psic1_e1,psic1_c2,psic2_e2,psic2_c1] = excentrickeStanoviskoCil(psie1_s1,psie1_c1,psie1_c2,psie2_c1,psie2_c2,es1,ec1,ec2,s12)
function [] = excentrickeStanoviskoCil(psie1_s1,psie1_c1,psie1_c2,psie2_c1,psie2_c2,es1,ec1,ec2,s12)

% ================
% vstupní hodnoty:
% ----------------
% psie1_c1,psie1_c2,psie1_s1 ... [rad] ... smery na excentrickem stanovisku
% psie2_c1,psie2_c2          ... [rad] ... smery na excentrickem cily
% es1               ... [m]  ... excentricita na stanovisku (pro stanovisko)
% ec1               ... [m]  ... excentricita na stanovisku (pro cil)
% ec2               ... [m]  ... excentricita na cili
% s12               ... [m]  ... vod. delka mezi centry
% cili zadavam vodorovnou delku merenou ze stanoviska na cil
% =================
% výstupní hodnoty:
% -----------------
% psic1_e1,psic1_c2,psic1_s1 ... [rad] ... smery na centrickem stanovisku
% psic2_e2,psic2_c1          ... [rad] ... smery na centrickem cili
;
    oms1 = psie1_s1 - psie1_c2;
    omc1 = psie1_c1 - psie1_c2;
    omc2 = psie2_c2 - psie2_c1;

    smk1(1) = 0;
    smk2(1) = 0;    
    diff1 = inf;
    diff2 = inf;
    i = 1;
    
    Xc1 = 0;Yc1 = 0;
    Xc2 = 0;Yc2 = 0;
    while(diff1 > 1e-16 || diff2 > 1e-16)
        
        Xs1 = es1*cos(smk1(i) + oms1);
        Ys1 = es1*sin(smk1(i) + oms1);
        
        Xc1 = ec1*cos(smk1(i) + omc1);
        Yc1 = ec1*sin(smk1(i) + omc1);
    
        Xc2 = ec2*cos(smk2(i) + omc2) + s12;
        Yc2 = ec2*sin(smk2(i) + omc2);
        
        smk1(i+1) = atan2(Yc2,Xc2);
        smk2(i+1) = atan2(Yc1,Xc1-s12);

        smk1(i+1) = zaradDoKvadrantu(smk1(i+1));
        smk2(i+1) = zaradDoKvadrantu(smk2(i+1));
        
        diff1 = abs(smk1(i+1) - smk1(i));  
        diff2 = abs(smk2(i+1) - smk2(i));
        i = i + 1;
    end

%     psic1_s1 = atan2(Ys1-Yc1,Xs1-Xc1);
%     psic1_e1 = atan2(  0-Yc1,  0-Xc1);
%     psic1_c2 = atan2(Yc2-Yc1,Xc2-Xc1);    
%     psic2_e2 = atan2(   -Yc2,s12-Xc2);
%     psic2_c1 = atan2(Yc1-Yc2,Xc1-Xc2);
%     
%     psic1_s1 = zaradDoKvadrantu(psic1_s1);
%     psic1_e1 = zaradDoKvadrantu(psic1_e1);
%     psic1_c2 = zaradDoKvadrantu(psic1_c2);
%     psic2_e2 = zaradDoKvadrantu(psic2_e2);
%     psic2_c1 = zaradDoKvadrantu(psic2_c1);
end