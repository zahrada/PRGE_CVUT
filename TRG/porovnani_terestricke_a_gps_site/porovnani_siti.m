clear all
clc
format long g

data = [
  1001	1002	0	0	0	0
  1001	1003	0	0	0	0
  1001	1004	0	0	0	0
  1002	1003	0	0	0	0
  1002	1004	0	0	0	0
  1003	1004	0	0	0	0
];

souradnice_gps = [
1001	1055371.3622	565726.4053
1002	1058509.0303	560712.2988
1003	1055295.5295	560932.5732
1004	1053012.1575	559774.3308
];

souradnice_vyr = [
1001	 1055371.310599	 565726.353469
1002	 1058508.995307	 560712.335863
1003	 1055295.529500	 560932.573200
1004	 1053012.187630	 559774.295974
];

for i = 1 : rows(data)
  data(i,3) = smernik(souradnice_vyr,data(i,1),data(i,2)) * 200 / pi;
  data(i,4) = smernik(souradnice_gps,data(i,1),data(i,2)) * 200 / pi;
  data(i,5) = delka(souradnice_vyr,data(i,1),data(i,2));
  data(i,6) = delka(souradnice_gps,data(i,1),data(i,2));
end
data