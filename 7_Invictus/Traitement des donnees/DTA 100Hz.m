%% Déclaration des variables
close all;
clear all;

filename = sprintf("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais Reglages Accel - Valbonne 16 07 21/16 07 21 Valbonne Accel MJT 4.Dat");
T = readtable(filename); 

N = height(T);
tau = 0.01; %intervalle de temps en s entre 2 mesures (10hz généralement)

%Vitesse de roue en m/s
lusp = str2double(strrep(table2array(T(1:N,4)),',','.'));
rusp = str2double(strrep(table2array(T(1:N,5)),',','.'));
ldsp = str2double(strrep(table2array(T(1:N,6)),',','.'));
rdsp = str2double(strrep(table2array(T(1:N,7)),',','.'));
RPM = table2array(T(1:N,3));
slip = table2array(T(1:N,8));
Shift = table2array(T(1:N,9));
time = 0:tau:(N-1)*tau;

Vitesse = (lusp+rusp)/2;
Traction = (ldsp+rdsp)/2; %vitesse roues arrière

Distance = cumtrapz(time,Vitesse*1000/3600);%distance en m

%% Analyse slip
plot(time,slip,"r");
hold on
plot(time,Vitesse,"b");
hold on
plot(time,Distance/10,"g");
hold on
plot(time,RPM/100,"k");
legend("Slip ratio", "vitesse","ditance","RPM")

