%% import .log test

clear

format shortg
c = clock;

% time(ms):1  Ax(g):9  Ay(g):10  Az(g):11  Yaw(°/s):12  Pitch(°/s):13  Roll(°/s):14  Lattitude(°):32
% longitude(°):33  speed(mph):34  height(ft):35  distance(ft):39

raw  = dlmread_empty('rc_1.log',',',1,0,NaN);

time = (raw(:,1)-raw(1,1))*10^-3;
time(end)

data = [];
for i= 1:length(raw)
    if abs(raw(i,11)) >= 0
        data = [data; raw(i,:)];
    end
end

fin = length(raw);
% clear data_raw

indic = 1;
data_gps = []; % [time:1 lattitude:2 longitude:3 speed:4 height:5 distance:6 Ax:7 Ay:8 Az:9 Yaw:10 Pitch:11 Roll:12]
for i=1:length(raw)
    if abs(raw(i,32)) > 0
        if raw(i,1) == data(indic,1)
            A = data(indic,9:14);
        else
           while raw(i,1) > data(indic,1) % && data_raw(i,1) > data(indic+1,1)
               indic = indic + 1;
           end
           a = (data(indic,9:14) - data(indic-1,9:14))./(data(indic,1) - data(indic-1,1));
           b = data(indic,9:14) - a*data(indic,1);
           A = a*raw(i,1) + b;
        end
        GPS = [raw(i,1) raw(i, 32:35) raw(i, 39) A];
        data_gps = [data_gps; GPS];
    end
end
data = [data(:,1:31) data(:,40:end)];

clear data_raw

b = clock;
b(end)-c(end);

time = (data_gps(:,1)-data_gps(1,1))*10^-3;
time(end);

%%

figure
plot((data_gps(:,1)-data_gps(1,1))*10^-3, data_gps(:,9))

% %%
% [X, Y] = lat_longi2X_Y(data_gps(:,2), data_gps(:,3));
% track_plot(X, Y, data_gps(:,7))
