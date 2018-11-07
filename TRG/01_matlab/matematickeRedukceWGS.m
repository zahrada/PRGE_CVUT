function [Dmat,delta] = matematickeRedukceWGS(Dfyz,B1_WGS,L1_WGS,H1_WGS,B2_WGS,L2_WGS,H2_WGS,hT1,hT2,R,k)
% ================
% vstupn� hodnoty:
% ----------------
% Dfyz          ... [m]   ... merena delka - opravena o konstantu hranolu + fyzik�ln� redukce
% hT1,hT2       ... [m]   ... v��ka stroje/c�le
% B1_WGS,L1_WGS ... [rad] ... elipsoidick� sou�adnice koncov�ho bodu
% H1_WGS        ... [m]   ... elipsoidick� v��ka koncov�ho bodu
% B2_WGS,L2_WGS ... [rad] ... elipsoidick� sou�adnice koncov�ho bodu
% H2_WGS        ... [m]   ... elipsoidick� v��ka koncov�ho bodu
% R             ... [m]   ... polom�r n�hradn� koule (pro opravu refrakce)
% k             ... []    ... refrak�n� koeficient
% =================
% v�stupn� hodnoty:
% -----------------
% Dmat  ... [m] ... delka opravena o vliv matematicke korekce
% delta ... [m] ... vliv fyzikalni korekce
;
    % 1) oprava refrakce
    r = R/k;
    d = 2*r*sin(Dfyz/(2*r));
    % 2) oprava ze zobrazen�
    % konstanty
    e_WGS = sqrt(0.006694379990141);
    a_WGS = 6378137.0;
    h = [4.998*pi/(3600*180),1.587*pi/(3600*180),5.261*pi/(3600*180)...
        ,-570.8,-85.7,-462.8,1-3.56*10^(-6)]'; % glob�ln� transforma�n� kl��
    % prevod z elipsoidick�ch sou�adnic na kart�zsk�
    [X1_WGS,Y1_WGS,Z1_WGS] = el2cart(B1_WGS,L1_WGS,H1_WGS+hT1,a_WGS,e_WGS);
    [X2_WGS,Y2_WGS,Z2_WGS] = el2cart(B2_WGS,L2_WGS,H2_WGS+hT2,a_WGS,e_WGS);    
    % prevod z wgs84 na S-JTSK
    [X1_JTSK,Y1_JTSK] = wgs2jtsk(B1_WGS,L1_WGS,H1_WGS+hT1,h);
    [X2_JTSK,Y2_JTSK] = wgs2jtsk(B2_WGS,L2_WGS,H2_WGS+hT2,h);
    % redukce
    d_XYZ0  = sqrt((X1_WGS - X2_WGS)^2 + (Y1_WGS - Y2_WGS)^2 + (Z1_WGS-Z2_WGS)^2);
    d_JTSK0 = sqrt((X1_JTSK-X2_JTSK)^2 + (Y1_JTSK-Y2_JTSK)^2);
    Dmat = d*(d_JTSK0/d_XYZ0);
    delta = Dmat - Dfyz;
end