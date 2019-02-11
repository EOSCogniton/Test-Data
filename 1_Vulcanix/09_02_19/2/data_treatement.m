clear all

%% Data loading

data0 = xlsread('Total_2.xlsx', 'rc_0');
% data1 = xlsread('Total_2.xlsx', 'rc_1');
% data2 = xlsread('Total_2.xlsx', 'rc_2');
% data3 = xlsread('Total_2.xlsx', 'rc_3');
% data4 = xlsread('Total_2.xlsx', 'rc_4');
% data5 = xlsread('Total_2.xlsx', 'rc_5');

time = data0(:,1);
latti_long = data0(:,32);
longi_long = data0(:,33);
speed_long = data0(:,34);
height_long = data0(:,35);

% data0 = data0(:,9:14);% data1 = data1(:,9:14); data2 = data2(:,9:14); data3 = data3(:,9:14); data4 = data4(:,9:14); data5 = data5(:,9:14);

clear data0

%% Data treatement

% datX_long = [data0(:,1); data1(:,1); data2(:,1); data3(:,1); data4(:,1); data5(:,1)]; 
% datY_long = [data0(:,2); data1(:,2); data2(:,2); data3(:,2); data4(:,2); data5(:,2)]; 
% datZ_long = [data0(:,3); data1(:,3); data2(:,3); data3(:,3); data4(:,3); data5(:,3)];
% datX_long = [data0(:,1)];
% datY_long = [data0(:,2)];
% datZ_long = [data0(:,3)];
 
% datYaw_long = [data0(:,4); data1(:,4); data2(:,4); data3(:,4); data4(:,4); data5(:,4)];
% datPitch_long = [data0(:,5); data1(:,5); data2(:,5); data3(:,5); data4(:,5); data5(:,5)];
% datRoll_long = [data0(:,6); data1(:,6); data2(:,6); data3(:,6); data4(:,6); data5(:,6)];
% datYaw_long = [data0(:,4)];
% datPitch_long = [data0(:,5)];
% datRoll_long = [data0(:,6)];

% datX = []; datY = []; datZ = []; datYaw = []; datPitch = []; datRoll = []; 
T = []; longitude = []; lattitude = []; speed = []; height = [];
for i=1:length(time)
%     if abs(time(i)) >= 0
%         datX = [datX; datX_long(i)];
%         datY = [datY; datY_long(i)];
%         datZ = [datZ; datZ_long(i)];
%         datYaw = [datYaw; datYaw_long(i)];
%         datPitch = [datPitch; datPitch_long(i)];
%         datRoll = [datRoll; datRoll_long(i)];
%         if i<=length(time)
%             T = [T; time(i)];
%             longitude = [longitude; longi_long(i)];
%             lattitude = [lattitude; latti_long(i)];
%             speed = [speed; speed_long(i)];
%             height = [height; height_long(i)];
%         T = [T; time(i)];
%         i
%     end
    if abs(longi_long(i)) > 0
        longitude = [longitude; longi_long(i)];
        lattitude = [lattitude; latti_long(i)];
        speed = [speed; speed_long(i)];
        height = [height; height_long(i)];
        T = [T; time(i)];
    end
end

clear data0 %data1 data2 data3 data4 data5
clear time longi_long latti_long speed_long height_long

%% Time

T = (T - T(1))*10^-3;

%% GPS data


lat_red = (lattitude - 45.7)*pi/180;
long_red = (longitude - 4.9094)*pi/180;

R = 6378137;

X = R .* tan(lat_red);
Y = R .* tan(long_red);

z = zeros(size(X'));
col = speed'*1.60934;  % This is the color, vary with x in this case.
surface([X';X'],[Y';Y'],[z;z],[col;col],'facecol','no','edgecol','interp','linew',2);
c = colorbar;
xlabel('X (m)')
ylabel('Y (m)')
c.Label.String = 'Vitesse Km/h';

%% plot

% figure
% plot(datX,datY,'o'), xlabel('Accélération longitudinale'), ylabel('Accélération laterale'), title("Cercle d'adhérence")
% 
% figure
% plot(datX,datZ-1,'o'), xlabel('Accélération longitudinale'), ylabel('Accélération verticale')

% figure
% plot(T,datYaw(1:length(T)))

% figure
% plot(T,speed*1.60934)

% %% Pitch integration
% 
% adjust_pitch = datPitch(1:length(T)) - mean(datPitch(1:length(T)));
% 
% pitch = T*0;
% for i=2:(length(T)-1)
%     pitch(i) = pitch(i-1) + (T(i+1)-T(i))*adjust_pitch(i+1);
% end
% pitch(length(T)) = pitch(length(T)-1);
% 
% figure
% plot(T,pitch)
% 
% %% Yaw integration
% 
% adjust_yaw = datYaw(1:length(T)) - mean(datYaw(1:length(T)));
% 
% yaw = T*0;
% for i=2:(length(T)-1)
%     yaw(i) = yaw(i-1) + (T(i+1)-T(i))*datYaw(i+1);
% end
% yaw(length(T)) = yaw(length(T)-1);
% 
% figure
% plot(T,yaw)
