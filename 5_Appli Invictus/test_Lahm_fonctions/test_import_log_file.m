%% import .log test

clear

format shortg
c = clock;

% time(ms):1  Ax(g):9  Ay(g):10  Az(g):11  Yaw(°/s):12  Pitch(°/s):13  Roll(°/s):14  Lattitude(°):32
% longitude(°):33  speed(mph):34  height(ft):35  distance(ft):39

raw  = dlmread_empty('rc_0.log',',',1,0,NaN);

time = (raw(:,1)-raw(1,1))*10^-3;
% time(end)

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

% time = (data_gps(:,1)-data_gps(1,1))*10^-3;
% time(end);

%%

% figure
% plot(abs(data(:,9)), abs(data(:,10)), '+')

% %% test cercle
% 
% u = data(:,9);
% v =  data(:,10);
% 
% xs = @(a) sqrt(a(2)^2 / ((a(2)/a(1))^2 + (u ./ v).^2));
% ys = @(a) v./u .* xs(a)';
% 
% % contrainte = @(a) - abs([xs(a)' ; ys(a)]) + abs([u ; v]);
% contrainte = @(a) [- abs([xs(a)' ; ys(a)]) + abs([u ; v]), []];
% 
% % nonlcon = @contrainte;
% 
% fonc = @(a) abs(a(1))+abs(a(2));
% 
% sol = fmincon(fonc, [1.3 1.5], [], [], [], [], [], [], contrainte);

% function [c,ceq] = circlecon(a)
% xs = sqrt(a(2)^2 / ((a(2)/a(1))^2 + (u ./ v).^2));
% ys = v./u .* xs';
% % c = contrainte(x);
% c = - abs([xs' ; ys]) + abs([u ; v]);
% ceq = [];
% end

%% test autrement

b = max(abs(data(:,10)));
a = max(abs(data(:,9)));

% x = data(:,9);
x = (-max(abs(data(:,9))):0.001:max(abs(data(:,9))));
y = b*sqrt(1 - (x/a).^2);

figure
hold on
plot(x,y, 'b')
plot(x,-y, 'b')
plot(data(:,9), data(:,10), '*')