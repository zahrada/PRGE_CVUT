clc
clear

%data gravimetr
% cb g_mer hour min

%data points
% cb B L Z[Bpv - priblizne vypoctene z merenych prevyseni]

% for plot must do proces_gravimetr for each one dataset
% compute fayodove redukce
high_first_niv = 655.708; % vyska pocatku nivelacniho poradu
first_point = 980938.593; %mGal cb 3408,01 vyska pocatku gravimetrickeho mereni

variable_gravimetr_usa=0.1175;
variable_gravimetr_rus=4.379;

% measure grav_data
filename = 'grav_data_morning_usa.txt';
[data,delimiterOut]=importdata(filename);
% coordinatace of high points in WGS84

morning_usa = proces_gravimetr(data,variable_gravimetr_usa,first_point);

% measure grav_data
filename = 'grav_data_morning_rus.txt';
[data,delimiterOut]=importdata(filename);
% coordinatace of high points in WGS84

morning_rus = proces_gravimetr(data,variable_gravimetr_rus,first_point);

% measure grav_data
filename = 'grav_data_afternoon_usa.txt';
[data,delimiterOut]=importdata(filename);
% coordinatace of high points in WGS84

afternoon_usa = proces_gravimetr(data,variable_gravimetr_usa,first_point);

% measure grav_data
filename = 'grav_data_afternoon_rus.txt';
[data,delimiterOut]=importdata(filename);

afternoon_rus = proces_gravimetr(data,variable_gravimetr_rus,first_point);

% only !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ours measure by points of
% VPN
measure_g = (morning_usa+morning_rus+afternoon_usa+afternoon_rus)/4;
measure_g_ours = measure_g(8:10,:);

%import points
filename = 'body.txt';
[points,delimiterOut]=importdata(filename);
[m n] = size(points);
points_decimal = zeros(m,4);

% sixty do decimal
for i = 1:m
    points_decimal(i,1) = points(i,1);
    points_decimal(i,2) = dms2deg(points(i,2),points(i,3),points(i,4))*pi/180;
    points_decimal(i,3) = dms2deg(points(i,5),points(i,6),points(i,7))*pi/180;
    points_decimal(i,4) = points(i,8);
end


for i = 1:m
    % normalni tize
    gama(i) = 978030*(1+0.005302*sin(points_decimal(i,2))*sin(points_decimal(i,2))- 0.000007*sin(2*points_decimal(i,2))*sin(2*points_decimal(i,2)));
    %gama(i) = 978032.7*(1+0.0053024*sin(points_decimal(i,2))*sin(points_decimal(i,2))- 0.0000058*sin(2*points_decimal(i,2))*sin(2*points_decimal(i,2)));
    % fayova anomalie
    g_fayah(i) = measure_g_ours(i,2)+0.3086*points_decimal(i,4)-gama(i);
end
%korekce z tihovzch anomalii

for i = 1: m-1
    %korekce z tihovzch anomalii
    korekce_tih_anom(i) = 0.0010193 * ((g_fayah(i+1)-g_fayah(i))/2) * (points_decimal(i+1,4)-points_decimal(i,4));
    % normalni ortometricka korekce
    norm_orto_korekce(i) = -0.0000254* (points_decimal(i,4)+(points_decimal(i+1,4)-points_decimal(i,4))/2 ) * ((points(i+1,4)-points(i,4))/2);
    %normalni prevyseni
    high_norm(i) = (points_decimal(i+1,4)-points_decimal(i,4))+korekce_tih_anom(i)/1000+norm_orto_korekce(i)/1000
    %normalni vysky
end
high_point(1) = high_first_niv;
high_point(2) = high_first_niv-high_norm(2); %!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11POZOR PORADI BODU 
high_point(3) = high_point(2)-high_norm(1); %!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11POZOR PORADI BODU 
high_point
