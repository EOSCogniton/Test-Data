%% Comparaison runs accel FSN21 - ax
close all;
clear all;

filename1 = sprintf("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/FSN21/FSN21 - RC Accel 1 MJT.log");
filename2 = sprintf("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/FSN21/FSN21 - RC Accel 2 MKI.log");
T1 = readtable(filename1);
T2 = readtable(filename2);

N1 = height(T1);
N2 = height(T2);

time1 = (table2array(T1(1:N1,1))-table2array(T1(1,1)))./1000;
time2 = (table2array(T2(1:N2,1))-table2array(T2(1,1)))./1000;

ax1 = table2array(T1(1:N1,10));
ax2 = table2array(T2(1:N2,10));

plot(time1(380:700),ax1(380:700),"r")
hold on
plot(time1(380:700),ax2(2200:2520),"g")
hold on
plot(time1(380:700),ax1(3000:3320),"b")
hold on
plot(time1(380:700),ax2(5500:5820),"k")
legend("Accel 1 MJT", "Accel 2 MJT", "Accel 1 MKI", "Accel 2 MKI")

%% Comparaison runs accel FSN21 - vitesse de roues

filename1dta = sprintf('/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/FSN21/FSN21 - Accel 1 MJT.Dat');
filename2dta = sprintf('/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/FSN21/FSN21 - Accel 2 MKI.Dat');
T1dta = readtable(filename1dta); 
T2dta = readtable(filename2dta); 
N1 = height(T1dta);
N2 = height(T2dta);
tau = 50;

%Vitesse de roue en m/s
lusp1 = str2double(strrep(table2array(T1dta(1:N1,9)),',','.'))./3.6;
rusp1 = str2double(strrep(table2array(T1dta(1:N1,10)),',','.'))./3.6;
Vroue1 = (lusp1+rusp1)/2;

lusp2 = str2double(strrep(table2array(T2dta(1:N2,9)),',','.'))./3.6;
rusp2 = str2double(strrep(table2array(T2dta(1:N2,10)),',','.'))./3.6;
Vroue2 = (lusp2+rusp2)/2;

plot(Vroue1(229:229+tau-1),"r")
hold on
plot(Vroue1(754:754+tau-1),"g")
hold on
plot(Vroue2(639:639+tau-1),"b")
hold on
plot(Vroue2(1298:1298+tau-1),"k")
legend("Accel 1 MJT","Accel 2 MJT","Accel 1 MKI","Accel 2 MKI")
xlabel("temps (1/10s)")
ylabel("vitesse (km/h)")
%% distance
dist11 = cumtrapz(transpose(linspace(0,0.1*(tau-1),tau)),Vroue1(229:229+tau-1));
dist12 = cumtrapz(transpose(linspace(0,0.1*(tau-1),tau)),Vroue1(754:754+tau-1));
dist21 = cumtrapz(transpose(linspace(0,0.1*(tau-1),tau)),Vroue2(639:639+tau-1));
dist22 = cumtrapz(transpose(linspace(0,0.1*(tau-1),tau)),Vroue2(1298:1298+tau-1));

plot(dist11,"r")
hold on
plot(dist12,"g")
hold on
plot(dist21,"b")
hold on
plot(dist22,"k")
legend("Accel 1 MJT","Accel 2 MJT","Accel 1 MKI","Accel 2 MKI")
xlabel("temps (1/10s)")
ylabel("distance (m)")

%% slip ratio
slip11 = table2array(T1dta(229:229+tau-1,17));
slip12 = table2array(T1dta(754:754+tau-1,17));
slip21 = table2array(T2dta(639:639+tau-1,17));
slip22 = table2array(T2dta(1298:1298+tau-1,17));

plot(slip11,"r")
hold on
plot(slip12,"g")
hold on
plot(slip21,"b")
hold on
plot(slip22,"k")
legend("Accel 1 MJT","Accel 2 MJT","Accel 1 MKI","Accel 2 MKI")
xlabel("temps (1/10s)")
ylabel("Slip ratio (%)")