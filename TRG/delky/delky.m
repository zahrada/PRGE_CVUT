clear all
clc
format long g

mereni = [
%C.b1  C.b2    hT[m]   hc[m]   t1 sucha/mokra[�C]   t2 sucha/mokra[�C]    p1[torr]  p2[torr]   h1[%]  h2[%]   d[m]
 1001  1003    1.638   1.497   19.4   16.4          24.2   19.5           694       701        74     66      4795.855
 1001  1003    1.638   1.498   21.2   16.5          24.3   19.3           694       701        64     66      4795.843
 1001  1002    1.638   1.510   19.5   16.0          23.0   18.5           694       705        70     65      5916.797
 1001  1002    1.638   1.510   21.9   16.8          24.3   19.0           694       705        64     66      5916.790
 1002  1001    1.535   1.610   21.0   17.5          17.5   14.5           705       694        71     72      5916.799
 1002  1001    1.535   1.610   24.0   18.5          20.0   17.0           705       694        70     74      5916.787
 1002  1003    1.535   1.497   23.0   18.5          24.2   19.5           705       701.5      65     70      3221.358
 1002  1003    1.535   1.500   24.3   19.0          24.3   19.2           705       701.1      65     65      3221.354
 1002  1004    1.535   1.480   21.0   17.5          19.0   16.0           705       687        71     74      5580.719
 1002  1004    1.535   1.480   24.0   18.5          21.5   16.0           705       687        70     65      5580.707
 1003  1002    1.533   1.51    20     16            20.5   17             701.5     705        66     70      3221.349 
 1003  1002    1.535   1.51    24.2   18            24.5   19             701.2     705        62     69      3221.342
 1003  1001    1.533   1.61    20     16            17.5   14.5           701.5     694        66     72      4795.834
 1003  1001    1.535   1.61    24.2   18            21.2   16.5           701.2     694        62     63      4795.817
 1004  1002    1.509   1.510   19     16            22     17.5           687       705        78     74      5580.681
 1004  1002    1.509   1.510   21     16            24     18.5           686       705        70     68      5580.673
];

for i = 1 : rows(mereni)
  mereni(i,14) = fyz_red(mereni(i,:));
end

for i = 1 : rows(mereni)
  mereni(i,15) = mat_red(mereni(i,:));
end
mereni

%  vysledky = [];
%  for i = 1 : 2 : (rows(mereni)-1)
%    vysledky((i+1)/2,:) = [mereni(i,1:2) mean([mereni(i,15),mereni(i+1,15)])];
%  end
%  vysledky