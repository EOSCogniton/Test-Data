%% import .log test

clear

data_raw  = dlmread_empty('rc_1.log',',',1,0,NaN);

data = [];
for i= 1:length(data_raw)
    if abs(data_raw(i,11)) >= 0
        data = [data; data_raw(i,:)];
    end
end
clear data_raw

data_gps = []; % [time lattitude longitude speed height distance]
for i=1:length(data)
    if abs(data(i,32)) > 0
        GPS = [data(i,1) data(i, 32:35) data(i, 39)];
        data_gps = [data_gps; GPS];
    end
end
data = [data(:,1:31) data(:,40:end)];

[X, Y] = lat_longi2X_Y(data_gps(:,2), data_gps(:,3));
track_plot(X, Y, data_gps(:,4))

