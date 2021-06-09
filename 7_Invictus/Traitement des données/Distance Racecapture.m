%% Initilisation : lecture des variables

close all;
clear all;

dist_total_cap = 0;
filename = sprintf("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais premiers reglages LAS - Transpolis 08 06 21/Log RC/rc_8.log");
T = readtable(filename);

N = height(T);

time = (table2array(T(1:N,1))-5383)./1000;

time5 = []; %Table du temps pour les capteurs à 10Hz
for i = 1:N
    if mod(i,5) == 0
        time5(end+1) = time(i);
    end
end

Distance_parcourue = table2array(T(end-5:end,56))


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
ylabel("acceleration (g ?)");
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

%% Vitesse
vDTA = table2array(T(1:N,24));
vRC = table2array(T(1:N,44));
SpeedDTA = [];
SpeedRC = [];

for i = 1:N
    if mod(i,5) == 0
        SpeedDTA(end+1) = vDTA(i);
        SpeedRC(end+1) = vRC(i);
    end
end
    
figure
plot(time5,SpeedDTA,'r');
hold on;
plot(time5,SpeedRC,'g');
legend("SpeedDTA","SpeedRC");
ylabel("Vitesse (km/h)");
xlabel("temps (s)")

%% Volant vs accélération latérale
VolantRC = table2array(T(1:N,9));
Steering = [];
AccelY5 = [];

for i = 1:N
    if mod(i,5) == 0
        Steering(end+1) = VolantRC(i)/70;
        AccelY5(end+1) = (ay(i) + ay(i-1) + ay(i-2) + ay(i-3) + ay(i-4))/5;
    end
end

    
figure
plot(time5,Steering,'r');
hold on;
plot(time5,AccelY5,'g');
legend("Steering","AccelY5");
title("Ay vs Steering");
xlabel("temps (s)")

