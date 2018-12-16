function [res] = proces_gravimetr(data,variable_gravimetr,first_point)
% data=[
% cb  g_mer  hour min
% 000 11.546 9 29.5
% 440 3.8774 9 52.5
% 430 4.426 10 08.5
% 401 5.6984 10 22
% 392 6.223 10 39.5
% 000 11.5554 10 50
% 391 6.6472 11 15.5
% 370 8.99 11 28.5
% 361 8.953 11 43.5
% 351 9.098 11 57.5
% 340 10.2614 12 8
% 000 11.100 12 19.5
% ]

res = zeros(length(data)-3,2);
k= 1;
data_first_measurment = zeros(3,4);
relative = data(1,3)*60+data(1,4);
for i= 1:length(data)
    % reduction hour and minut to minut, reference first measure is null
    data(i,3) = (data(i,3)*60 + data(i,4))-relative;
    % reduction of varable gravimetr
    data(i,2) = data(i,2)* variable_gravimetr;
    if data(i,1) == 0
        
        data_first_measurment(k,:) = data(i,:);
        k = k+1;
    end
end


% regressinon line
x = zeros(3,2);
x = [ones(length(x),1)  data_first_measurment(:,3)];
y = data_first_measurment(:,2);
b= x\y;

% difference of change gravimetr
difference = data(:,2)*b(2);

% reduction measure by difference of change gravimetr
data(:,2) = data(:,2)-difference;

average = 0;
for i= 1: length(data)
    if data(i,1) == 0
        average = average + data(i,2);
    end
end
average= average/3;

for i =1: length(data)
    data(i,2) = data(i,2) - average + first_point;
end
 

res = data;

y = b(1)+ data_first_measurment(:,3)*b(2);

plot(data_first_measurment(:,3), data_first_measurment(:,2),'x',data_first_measurment(:,3),y);
end


