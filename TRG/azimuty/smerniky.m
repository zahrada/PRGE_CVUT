format long g

mereni = [
1001  1003      298.929021266052
1001  1003      298.928594857341
1001  1003      298.912649825037
1001  1003      298.91593969276
%  1001  1002      335.505237286276
%  1001  1002      335.918768687464
%  1001  1002      335.505740870993
%  1001  1002      335.50259707617
1002  1004      210.898869170231
1002  1004      210.901827578536
1002  1004      210.897553411704
1002  1004      210.894318377803
1002  1004      210.900098718071
1002  1004      210.900917408672
1002  1004      210.900714362444
1002  1004      210.897303620222
1002  1004      210.900347882453
1002  1004      210.897930199081
1002  1004      210.901215906017
1002  1004      210.899309350358
1003  1004      230.01131966536
1003  1004      230.02501733054
1003  1004      230.0056502543
1003  1004      230.016345440451
1003  1004      230.010813165116
1003  1004      230.024057782778
1003  1004      230.013246327138
1003  1004      230.016093097062
1003  1004      230.011701674422
1003  1004      230.018142091077
1003  1004      230.016428640512
1003  1004      230.017032144709
1004  1003       30.0401377262468
1004  1003       30.0340452128325
1004  1003       30.036463418185
1004  1003       30.0373107020312
1004  1003       30.0368571177771
1004  1003       30.0405172633875
1004  1003       30.0359119427084
1004  1003       30.0341543939307
1004  1003       30.0464935937837
1004  1003       30.0324031378298
1004  1003       30.0389246674715
1004  1003       30.0359736710123
];

mereni2 = [];
for i = 1 : 2 : rows(mereni)-1
  mereni2 = [mereni2; mereni(i,1:2) mean([mereni(i,3) mereni(i+1,3)])];
end
mereni2

v = [];
for i = 1 : 2 : rows(mereni2)-1
  prumer = mean([mereni2(i,3) mereni2(i+1,3)]);
  v = [v; prumer - mereni2(i,3); prumer - mereni2(i+1,3);];
end

sigma_2jednotky = sqrt((v' * v)/(rows(mereni2)/2))
sigma_6jednotek = sigma_2jednotky/sqrt(3)
sigma_15jednotky = sigma_2jednotky * sqrt(2) / sqrt(1.5)