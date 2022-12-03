close all;
clear all;

dist_total_cap = 0;
filename = sprintf("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais St Priest 17 07 2021/17 07 21 5 Endurance MKI.Dat");
T = readtable(filename); 

N = height(T);
tau = 0.1; %intervalle de temps en s entre 2 mesures (10hz généralement)

%Vitesse de roue en m/s
lusp = str2double(strrep(table2array(T(1:N,9)),',','.'))./3.6;
rusp = str2double(strrep(table2array(T(1:N,10)),',','.'))./3.6;

%% Distance parcourue
%% Méthode implémentée 
dist_left = trapz(linspace(0,0.1*(N-1),N),lusp)
dist_right = trapz(linspace(0,0.1*(N-1),N),rusp)

dist_total = (dist_left + dist_right )/2000

%% Méthode à la main

dl = 0;
dr = 0;

for i = 2:N;
    l = (lusp(i)+lusp(i-1))/2; %vitesse moyenne gauche
    dl = dl + l*tau;
    
    r = (rusp(i)+rusp(i-1))/2;
    dr = dr + r*tau;
end
    
d = (dl + dr)/2/1000

%% Essai carburant consommé, moyenne conso moyenne

conso = str2double(strrep(table2array(T(1:N,18)),',','.'));
cons_adj = [];
sum_cons = 0;
for i = 1:N
    if conso(i) ~= 0
        cons_adj(end +1) = conso(i);
        sum_cons = sum_cons + conso(i);
    end
end

nb = length(cons_adj);
sum_cons/nb*d/100 %consommation moyenne (L/100km)

%% Conso, somme des quantités injectées

inj = str2double(strrep(table2array(T(1:N,16)),',','.'));
rpds = table2array(T(1:N,3))/60*tau; %tours par déciseconde (0,1s)

inj = inj .* rpds * 2; %temps d'injection par ds en ms
total_inj = sum(inj)/1000*3.87/1000

