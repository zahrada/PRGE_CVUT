function [B,L,H]=najdi_souradnice(bod)

souradnice_wgs;

B = souradnice_wgs(find(souradnice_wgs(:,1)==bod), 2:4);
L = souradnice_wgs(find(souradnice_wgs(:,1)==bod), 5:7);
H = souradnice_wgs(find(souradnice_wgs(:,1)==bod), 8);


