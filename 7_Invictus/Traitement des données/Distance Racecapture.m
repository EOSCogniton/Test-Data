%% Initilisation : lecture des variables

close all;
clear all;

dist_total_cap = 0;
filename = sprintf("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais Reglages Accel - Valbonne 16 07 21/16 07 21 Valbonne - Accel TLS 2.log");
T = readtable(filename);

N = height(T);

time = (table2array(T(1:N,1))-table2array(T(1,1)))./1000;

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

FuelP = table2array(T(1:N,26));
RPM = table2array(T(1:N,19));


%% Plots de distance

plot(time,ax,'r');
hold on;
plot(time,ay,'g');
hold on;
plot(time,RPM/10000,'k');
legend("ax","ay","RPM");
ylabel("acceleration (g ?)");
xlabel("temps (s)")

figure
plot(time,vx,'r');
hold on;
plot(time,vy,'g');
legend("vx","vy");
ylabel("vitesse (m/s)");
xlabel("temps (s)")

figure
plot(time,dx,'r');
hold on;
plot(time,dy,'g');
legend("dx","dy");
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

%% Pitch

HRF = table2array(T(1:N,5));
HLF = table2array(T(1:N,6));
HLR = table2array(T(1:N,7));
HRR = table2array(T(1:N,8));

for i = 1:N
    if mod(i,5) == 0
        HRF(i-4) = HRF(i);
        HRF(i-3) = HRF(i);
        HRF(i-2) = HRF(i);
        HRF(i-1) = HRF(i);
        HLF(i-4) = HLF(i);
        HLF(i-3) = HLF(i);
        HLF(i-2) = HLF(i);
        HLF(i-1) = HLF(i);
        HRR(i-4) = HRR(i);
        HRR(i-3) = HRR(i);
        HRR(i-2) = HRR(i);
        HRR(i-1) = HRR(i);
        HLR(i-4) = HLR(i);
        HLR(i-3) = HLR(i);
        HLR(i-2) = HLR(i);
        HLR(i-1) = HLR(i);
    end
end
    
figure
plot(time,HRF,'r');
hold on;
plot(time,HLF,'r--');
hold on;
plot(time,HRR,'g');
hold on;
plot(time,HLR,'g--');
legend("Height RF","Height LF","Height RR","Height LR");
ylabel("débattement capteur (mm)");
xlabel("temps (s)")

%% Corrélation de déjaugement
figure
plot(time,ax*4,'r');
hold on;
plot(time,FuelP,'g');
legend("ay*4","FuelP");
ylabel("Accélération y et FuelPressure");
xlabel("temps (s)")

%% Calcul de la consommation
Conso_100 = table2array(T(1:N,28));
distance_adaptee = [];
for i=1:N
    if mod(i,5)==0
        dist = table2array(T(i,56));
        distance_adaptee(i)=dist;
        distance_adaptee(i+1)=dist;
        distance_adaptee(i+2)=dist;
        distance_adaptee(i+3)=dist;
        distance_adaptee(i+4)=dist;
    end
end
Total_conso = cumtrapz(distance_adaptee,Conso_100/100);
Total_conso(end) %Consommation sur le run
Total_conso(end)/distance_adaptee(end)*100

%% Temps

sector = table2array(T(1:N,52));
sector5 = []; %Table du temps pour les capteurs à 10Hz
for i = 1:N
    if mod(i,5) == 0
        sector5(end+1) = time(i);
    end
end
plot(sector5)