function [Dmat,delta] = matematickeRedukceJtsk(Dfyz,X1_JTSK,Y1_JTSK,H1_Bessel,X2_JTSK,Y2_JTSK,H2_Bessel,hT1,hT2,R,k)
% ================
% vstupn� hodnoty:
% ----------------
% Dfyz            ... [m]   ... merena delka - opravena o konstantu hranolu + fyzik�ln� redukce
% hT1,hT2         ... [m]   ... v��ka stroje/c�le
% X1_JTSK,Y1_JTSK ... [rad] ... elipsoidick� sou�adnice koncov�ho bodu
% H1_Bessel       ... [m]   ... elipsoidick� v��ka koncov�ho bodu
% X2_JTSK,Y2_JTSK ... [rad] ... elipsoidick� sou�adnice koncov�ho bodu
% H2_Bessel       ... [m]   ... elipsoidick� v��ka koncov�ho bodu
% R               ... [m]   ... polom�r n�hradn� koule (pro opravu refrakce)
% k               ... []    ... refrak�n� koeficient
% =================
% v�stupn� hodnoty:
% -----------------
% Dmat  ... [m] ... delka opravena o vliv matematicke korekce
% delta ... [m] ... vliv fyzikalni korekce
;
    % 1) oprava refrakce
    r = R/k;
    d = 2*r*sin(Dfyz/(2*r))
    % 2) oprava ze zobrazen�
    % konstanty
    e_Bessel = sqrt(0.006674372230622);
    a_Bessel = 6377397.15508;    
    % prevod na kart�zsk� sou�adnice
    [B1_Bessel,L1_Bessel] = jtsk2bes(X1_JTSK,Y1_JTSK);
    [X1_Bessel,Y1_Bessel,Z1_Bessel] = el2cart(B1_Bessel,L1_Bessel,H1_Bessel+hT1,a_Bessel,e_Bessel)
    [B2_Bessel,L2_Bessel] = jtsk2bes(X2_JTSK,Y2_JTSK);
    [X2_Bessel,Y2_Bessel,Z2_Bessel] = el2cart(B2_Bessel,L2_Bessel,H2_Bessel+hT2,a_Bessel,e_Bessel)    
    % redukce
    d_XYZ0  = sqrt((X1_Bessel - X2_Bessel)^2 + (Y1_Bessel - Y2_Bessel)^2 + (Z1_Bessel-Z2_Bessel)^2)
    d_JTSK0 = sqrt((X1_JTSK-X2_JTSK)^2 + (Y1_JTSK-Y2_JTSK)^2)
    Dmat = d*(d_JTSK0/d_XYZ0);
    delta = Dmat - Dfyz;
end