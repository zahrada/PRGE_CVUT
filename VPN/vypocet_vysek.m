clear all
clc
format long g

data=[
37	    698.243		0		50	12	58.89862	16	55	18.03673	980925.399	%37
39.1	0		30.00327	50	13	 5.45004	16	55	32.66677	980918.610	%39.1
43	    0		56.59907	50	13	11.15951	16	55	29.54966	980908.192	%43
44	    0		15.95779	50	13	23.77813	16	55	25.16813	980905.029	%44
];

%upravena data
for i = 1 : rows(data)
  data_upravena(i, 1) = data(i, 1);
  data_upravena(i, 2) = data(i, 2);
  data_upravena(i, 3) = data(i, 3);
  data_upravena(i, 4) = data(i, 4) + data(i, 5)/60 +  data(i, 6)/3600;
  data_upravena(i, 5) = data(i, 10);
end

%Pøiblinı vıpoèet vıšek
for i = 2 : rows(data)
  data_upravena(i, 2) = data_upravena(i-1, 2) + data_upravena(i, 3);
end

%vıpoèet gama
for i = 1 : rows(data)
  B = data_upravena(i, 4) * pi/180;
  Hi = data_upravena(i, 2);
  data_upravena(i, 6) = (978030 * (1 + 0.005302 * ((sin(B))^2) - 0.000006 * ((sin(2*B))^2)) - (0.3086 * Hi)); %ve vıšce H nad elipsoidem
  data_upravena(i, 10) = 978030 * (1 + 0.005302 * ((sin(B))^2) - 0.000006 * ((sin(2*B))^2)); %na elipsoidu
end

%vıpoèet Kg
data_upravena(1, 7) = 0;
for i = 1 : (rows(data)-1)
  gi = data_upravena(i, 5);
  gii = data_upravena(i+1, 5);
  gamai = data_upravena(i, 6);
  gamaii = data_upravena(i+1, 6);
  dH = data_upravena(i+1, 3);
  delta_g = ((gi-gamai)+(gii-gamaii))/2;
  data_upravena(i+1, 7) = 0.0010193 * delta_g * dH;
end

%vıpoèet Kgama
data_upravena(1, 8) = 0;
for i = 1 : (rows(data)-1)
  Hi = data_upravena(i, 2);
  Hii = data_upravena(i+1, 2);
  Bi = data_upravena(i, 4);
  Bii = data_upravena(i+1, 4);
  delta_B = (Bii-Bi)*3600;
  Hs = (Hii + Hi)/2;
  data_upravena(i+1, 8) = -0.0000254 * delta_B * Hs;
end

%Koneènı vıpoèet vıšek
for i = 2 : rows(data)
  data_upravena(i, 2) = data_upravena(i-1, 2) + data_upravena(i, 3) + data_upravena(i, 7)/1000 + data_upravena(i, 8)/1000;
end

%Bouguerova anomálie
for i = 1 : rows(data_upravena)
  data_upravena(i,9) = data_upravena(i,5) + 0.3086 * data_upravena(i,2) - 0.1119 * data_upravena(i,2) - data_upravena(i,10) + 14;
  data_upravena(i,11) = 0.3086 * data_upravena(i,2);
  data_upravena(i,12) = 0.1119 * data_upravena(i,2);
end

disp(['-----------------------------------------------------------------------------------------------------------------------------------------'])
disp(['|  c.b	|  H [m]	|  Kg [mm]	|  Kgama [mm]	|  Gs [mGal]	|  Gn [mGal]	| deltaF [mGal]	| deltaB [mGal]	|  Ba [mGal]	|'])
disp(['-----------------------------------------------------------------------------------------------------------------------------------------'])
for i = 1 : rows(data)
  disp(['|  ' num2str(data_upravena(i,1),3) '	|  ' num2str(data_upravena(i,2),8) '	|  ' num2str(data_upravena(i,7),'%1.2f') '		|  ' num2str(data_upravena(i,8),'%1.2f') '	|  ' num2str(data_upravena(i,5),'%6.1f') '	|  ' num2str(data_upravena(i,10),'%6.1f') '	|  ' num2str(data_upravena(i,11),'%2.1f') '	|  ' num2str(data_upravena(i,12),'%2.1f') '		|  ' num2str(data_upravena(i,9),'%2.1f') '	|'])
end
disp(['-----------------------------------------------------------------------------------------------------------------------------------------'])