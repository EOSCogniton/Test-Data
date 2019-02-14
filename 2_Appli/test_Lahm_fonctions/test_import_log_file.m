%% import .log test

clear

format shortg
c = clock;
c(end);

data_raw  = dlmread_empty('rc_1.log',',',1,0,NaN);

data = [];
for i= 1:length(data_raw)
    if abs(data_raw(i,11)) >= 0
        data = [data; data_raw(i,:)];
    end
end

% R = cellfun(@(x) ) 

clear data_raw

data_gps = []; % [time lattitude longitude speed height distance]
for i=1:length(data)
    if abs(data(i,32)) > 0
        GPS = [data(i,1) data(i, 32:35) data(i, 39)];
        data_gps = [data_gps; GPS];
    end
end
data = [data(:,1:31) data(:,40:end)];

b = clock;
b(end)-c(end)

% [X, Y] = lat_longi2X_Y(data_gps(:,2), data_gps(:,3));
% track_plot(X, Y, data_gps(:,4))

%% test cellfun

a = [[1 2 3]; [4 5 6]; [7 8 9]];

b = num2cell(a);

c = cellfun(@(x) x>5, b)

%% test 2

clear

format shortg
c = clock;
c(end);

raw  = dlmread_empty('rc_1.log',',',1,0,NaN);
raw = num2cell(raw);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''}; 
            
% Replace non-numeric cells with 100000
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {100000}; % Replace non-numeric cells
            
% Create output variable
data = reshape([raw{:}],size(raw));

b = clock;
b(end)-c(end)