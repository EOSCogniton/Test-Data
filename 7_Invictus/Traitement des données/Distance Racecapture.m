%% Initilisation : lecture des variables

close all;
clear all;

dist_total_cap = 0;
filename = sprintf('/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/4_Optimus/23_06_19/JMN/rc_1.log');
T = readtable(filename);

N = height(T);

time = (table2array(T(1:N,1))-5383)./1000;

%% Distance 

ax = table2array(T(1:N,10));
ay = table2array(T(1:N,11));
az = table2array(T(1:N,12));

vx = cumtrapz(linspace(0,0.04*(N-1),N),ax);
dx = cumtrapz(linspace(0,0.04*(N-1),N),vx);

vy = cumtrapz(linspace(0,0.04*(N-1),N),ay);
dy = cumtrapz(linspace(0,0.04*(N-1),N),vy);

vz = cumtrapz(linspace(0,0.04*(N-1),N),az);
dz = cumtrapz(linspace(0,0.04*(N-1),N),vz);

%% Plots de distance

plot(time,ax,'r');
hold on;
plot(time,ay,'g');
hold on;
plot(time,az,'b');
legend("ax","ay","az");
ylabel("acceleration (m/s^2)");
xlabel("temps (s)")

figure
plot(time,vx,'r');
hold on;
plot(time,vy,'g');
hold on;
plot(time,vz,'b');
legend("vx","vy","vz");
ylabel("vitesse (m/s)");
xlabel("temps (s)")

figure
plot(time,dx,'r');
hold on;
plot(time,dy,'g');
hold on;
plot(time,dz,'b');
legend("dx","dy","dz");
ylabel("position (m)");
xlabel("temps (s)")

%% Freinage
BF = table2array(T(1:N,3));
BR = table2array(T(1:N,4));
Brake_F = [];
Brake_R = [];

for i = 1:N
    if mod(i,5) == 0
        Brake_F(end+1) = BF(i);
        Brake_R(end+1) = BR(i);
    end
end



    
    
    
    
    