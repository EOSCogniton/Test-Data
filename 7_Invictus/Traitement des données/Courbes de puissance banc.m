clear all;
close all;

%Les cartos ont été développées ainsi :
%v1 inspirée d'Optimus v6.4 (cartographe Invictus initiale)
%v2 obtenue après la 1ère session sur banc
%v3 obtenue après la 2ème session sur banc
%v4 obtenue après la 3ème session sur banc

T_11 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais sur banc - Givors 29 01 21/data_tir_puissance_1_tir_1.txt");
%T_11 : Tir de puissance cartographie v1.3, session 1, tir 1
T_12 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais sur banc - Givors 29 01 21/data_tir_puissance_1_tir_2.txt");
%T_12 : Tir de puissance cartographie v1.3, session 1, tir 2

T_21 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 05 03 21/SE-20-002-E02/SE-20-002-E02_1_carto_base.txt");
%T_21 : Tir de puissance cartographie v1.3, session 2, tir 1
T_22 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 05 03 21/SE-20-002-E02/SE-20-002-E02_2_carto_base.txt");
%T_22 : Tir de puissance cartographie v1.3, session 2, tir 2
T_23 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 05 03 21/SE-20-002-E02/SE-20-002-E02_3_carto_base.txt");
%T_23 : Tir de puissance cartographie v1.3, session 2, tir 3
T_24 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 05 03 21/SE-20-002-E02/SE-20-002-E02_1_carto_modif_session_1.txt");
%T_24 : Tir de puissance cartographie v2.0, session 2, tir 1
T_25 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 05 03 21/SE-20-002-E02/SE-20-002-E02_2_carto_modif_session_1.txt");
%T_25 : Tir de puissance cartographie v2.0, session 2, tir 2
T_26 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 05 03 21/SE-20-002-E04/SE-20-002-E04_1.txt");
%T_26 : Tir de puissance cartographie v2.1, session 2, tir 1 - Optimasation
%4-5k ?
T_27 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 05 03 21/SE-20-002-E04/SE-20-002-E04_2.txt");
%T_27 : Tir de puissance cartographie v2.1, session 2, tir 2 - Optimasation
%4-5k ?
T_28 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 05 03 21/SE-20-002-E04/SE-20-002-E04_apres_5000_modif.txt");
%T_28 : Tir de puissance cartographie v2.2, session 2, tir 1 - Optimasation
%5k
T_29 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 05 03 21/SE-20-002-E09/SE-20-002-E09_1.txt");
%T_29 : Tir de puissance cartographie v3, session 2, tir 1
T_210 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 05 03 21/SE-20-002-E09/SE-20-002-E09_2.txt");
%T_210 : Tir de puissance cartographie v3, session 2, tir 2

T_31 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 30 04 21/SE-20-003-E01/SE-20-003-E01_1_recoupement.txt");
%T_31 : Tir de puissance cartographie v3.0, session 3, tir 1
T_32 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 30 04 21/SE-20-003-E01/SE-20-003-E01_2_recoupement.txt");
%T_32 : Tir de puissance cartographie v3.0, session 3, tir 2
T_33 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 30 04 21/SE-20-003-E01/SE-20-003-E01_3_recoupement.txt");
%T_33 : Tir de puissance cartographie v3.0, session 3, tir 3 - (calib knock
%sensor)
T_34 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 30 04 21/SE-20-003-E01/SE-20-003-E01_4_recoupement.txt");
%T_34 : Tir de puissance cartographie v3.0, session 3, tir 4 - (calib knock
%sensor)
T_35 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 30 04 21/SE-20-003-E01/SE-20-003-E01_5_tir.txt");
%T_35 : Tir de puissance cartographie v3.4, session 3, tir 1 - Opti 2-7k
T_36 = readtable("/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session d'essais banc moteur - Givors 30 04 21/SE-20-003-E01/SE-20-003-E01_6_tir.txt");
%T_36 : Tir de puissance cartographie v3.4, session 3, tir 2 - Opti 2-7k

% 2 : Vitesse moteur (tr/min) !!!!
% 3 : Puissance brute mesurée (ch)
% 4 : Puissance à la roue (ch) 
% 5 : Puissance roue corrigée (ch) !!!!
% 6 : Couple corrigé Roue (N.m) !!!!
% 7 : Puissance corrigée moteur (ch) !!!!
% 8 : Couple corrigé moteur (N.m) !!!!
% 9 : Vitesse véhicule (km/h)
% 10 : Temps acquisition mesure (s)
% 11 : Force à la roue (N)
% 12 : Accéléraition Linéaire (mm/s^2)
% 14 : Couple moteur brut
% 15 : Puissance Pertes Calibrées Totales
% 16 : Puissance Pertes Calibrées Banc
% 17 : Puissance Pertes Calibrées Véhicule
% 18 : Couple brut
% 19 : Facteur de correction
% 20 : Rapport de sortie
% 21 : Rapport Global Dynamique
% 22 : Facteur de pertes de transmission


%%

RPM_11 = table2array(T_11(1:end,2));
Proue_11 = str2double(strrep(table2array(T_11(1:end,5)),',','.'));
Croue_11 = str2double(strrep(table2array(T_11(1:end,6)),',','.'));
Pengine_11 = str2double(strrep(table2array(T_11(1:end,7)),',','.'));
Cengine_11 = str2double(strrep(table2array(T_11(1:end,8)),',','.'));

RPM_12 = table2array(T_12(1:end,2));
Proue_12 = str2double(strrep(table2array(T_12(1:end,5)),',','.'));
Croue_12 = str2double(strrep(table2array(T_12(1:end,6)),',','.'));
Pengine_12 = str2double(strrep(table2array(T_12(1:end,7)),',','.'));
Cengine_12 = str2double(strrep(table2array(T_12(1:end,8)),',','.'));



RPM_21 = table2array(T_21(1:end,2));
Proue_21 = str2double(strrep(table2array(T_21(1:end,5)),',','.'));
Croue_21 = str2double(strrep(table2array(T_21(1:end,6)),',','.'));
Pengine_21 = str2double(strrep(table2array(T_21(1:end,7)),',','.'));
Cengine_21 = str2double(strrep(table2array(T_21(1:end,8)),',','.'));

RPM_22 = table2array(T_22(1:end,2));
Proue_22 = str2double(strrep(table2array(T_22(1:end,5)),',','.'));
Croue_22 = str2double(strrep(table2array(T_22(1:end,6)),',','.'));
Pengine_22 = str2double(strrep(table2array(T_22(1:end,7)),',','.'));
Cengine_22 = str2double(strrep(table2array(T_22(1:end,8)),',','.'));

RPM_23 = table2array(T_23(1:end,2));
Proue_23 = str2double(strrep(table2array(T_23(1:end,5)),',','.'));
Croue_23 = str2double(strrep(table2array(T_23(1:end,6)),',','.'));
Pengine_23 = str2double(strrep(table2array(T_23(1:end,7)),',','.'));
Cengine_23 = str2double(strrep(table2array(T_23(1:end,8)),',','.'));

RPM_24 = table2array(T_24(1:end,2));
Proue_24 = str2double(strrep(table2array(T_24(1:end,5)),',','.'));
Croue_24 = str2double(strrep(table2array(T_24(1:end,6)),',','.'));
Pengine_24 = str2double(strrep(table2array(T_24(1:end,7)),',','.'));
Cengine_24 = str2double(strrep(table2array(T_24(1:end,8)),',','.'));

RPM_25 = table2array(T_25(1:end,2));
Proue_25 = str2double(strrep(table2array(T_25(1:end,5)),',','.'));
Croue_25 = str2double(strrep(table2array(T_25(1:end,6)),',','.'));
Pengine_25 = str2double(strrep(table2array(T_25(1:end,7)),',','.'));
Cengine_25 = str2double(strrep(table2array(T_25(1:end,8)),',','.'));

RPM_26 = table2array(T_26(1:end,2));
Proue_26 = str2double(strrep(table2array(T_26(1:end,5)),',','.'));
Croue_26 = str2double(strrep(table2array(T_26(1:end,6)),',','.'));
Pengine_26 = str2double(strrep(table2array(T_26(1:end,7)),',','.'));
Cengine_26 = str2double(strrep(table2array(T_26(1:end,8)),',','.'));

RPM_27 = table2array(T_27(1:end,2));
Proue_27 = str2double(strrep(table2array(T_27(1:end,5)),',','.'));
Croue_27 = str2double(strrep(table2array(T_27(1:end,6)),',','.'));
Pengine_27 = str2double(strrep(table2array(T_27(1:end,7)),',','.'));
Cengine_27 = str2double(strrep(table2array(T_27(1:end,8)),',','.'));

RPM_28 = table2array(T_28(1:end,2));
Proue_28 = str2double(strrep(table2array(T_28(1:end,5)),',','.'));
Croue_28 = str2double(strrep(table2array(T_28(1:end,6)),',','.'));
Pengine_28 = str2double(strrep(table2array(T_28(1:end,7)),',','.'));
Cengine_28 = str2double(strrep(table2array(T_28(1:end,8)),',','.'));

RPM_29 = table2array(T_29(1:end,2));
Proue_29 = str2double(strrep(table2array(T_29(1:end,5)),',','.'));
Croue_29 = str2double(strrep(table2array(T_29(1:end,6)),',','.'));
Pengine_29 = str2double(strrep(table2array(T_29(1:end,7)),',','.'));
Cengine_29 = str2double(strrep(table2array(T_29(1:end,8)),',','.'));

RPM_210 = table2array(T_210(1:end,2));
Proue_210 = str2double(strrep(table2array(T_210(1:end,5)),',','.'));
Croue_210 = str2double(strrep(table2array(T_210(1:end,6)),',','.'));
Pengine_210 = str2double(strrep(table2array(T_210(1:end,7)),',','.'));
Cengine_210 = str2double(strrep(table2array(T_210(1:end,8)),',','.'));



RPM_31 = table2array(T_31(1:end,2));
Proue_31 = str2double(strrep(table2array(T_31(1:end,5)),',','.'));
Croue_31 = str2double(strrep(table2array(T_31(1:end,6)),',','.'));
Pengine_31 = str2double(strrep(table2array(T_31(1:end,7)),',','.'));
Cengine_31 = str2double(strrep(table2array(T_31(1:end,8)),',','.'));

RPM_32 = table2array(T_32(1:end,2));
Proue_32 = str2double(strrep(table2array(T_32(1:end,5)),',','.'));
Croue_32 = str2double(strrep(table2array(T_32(1:end,6)),',','.'));
Pengine_32 = str2double(strrep(table2array(T_32(1:end,7)),',','.'));
Cengine_32 = str2double(strrep(table2array(T_32(1:end,8)),',','.'));

RPM_33 = table2array(T_33(1:end,2));
Proue_33 = str2double(strrep(table2array(T_33(1:end,5)),',','.'));
Croue_33 = str2double(strrep(table2array(T_33(1:end,6)),',','.'));
Pengine_33 = str2double(strrep(table2array(T_33(1:end,7)),',','.'));
Cengine_33 = str2double(strrep(table2array(T_33(1:end,8)),',','.'));

RPM_34 = table2array(T_34(1:end,2));
Proue_34 = str2double(strrep(table2array(T_34(1:end,5)),',','.'));
Croue_34 = str2double(strrep(table2array(T_34(1:end,6)),',','.'));
Pengine_34 = str2double(strrep(table2array(T_34(1:end,7)),',','.'));
Cengine_34 = str2double(strrep(table2array(T_34(1:end,8)),',','.'));

RPM_35 = table2array(T_35(1:end,2));
Proue_35 = str2double(strrep(table2array(T_35(1:end,5)),',','.'));
Croue_35 = str2double(strrep(table2array(T_35(1:end,6)),',','.'));
Pengine_35 = str2double(strrep(table2array(T_35(1:end,7)),',','.'));
Cengine_35 = str2double(strrep(table2array(T_35(1:end,8)),',','.'));

RPM_36 = table2array(T_36(1:end,2));
Proue_36 = str2double(strrep(table2array(T_36(1:end,5)),',','.'));
Croue_36 = str2double(strrep(table2array(T_36(1:end,6)),',','.'));
Pengine_36 = str2double(strrep(table2array(T_36(1:end,7)),',','.'));
Cengine_36 = str2double(strrep(table2array(T_36(1:end,8)),',','.'));


%% Evolution des cartographies (puissance à la roue)

figure
title("Evolution des cartographies (puissance à la roue)");
grid on
hold on
%plot(RPM_12,Proue_12) %v1.3 session 1 - comparaison inutile...
plot(RPM_21,Proue_21) %v1.3 session 2
plot(RPM_25,Proue_25) %v2.0 session 2
plot(RPM_27,Proue_27) %v2.1 session 2
plot(RPM_28,Proue_28) %v2.2 session 2
%plot(RPM_29,Proue_29) %v3.0 session 2 - verif de régularité avec 32
plot(RPM_32,Proue_32) %v3.0 session 3
plot(RPM_35,Proue_35) %v3.4 session 3
legend("v1.3","v2.0","v2.1","v2.2","v3.0","v3.4")
xlabel("RPM (tr/min)")
ylabel("Puissance à la roue (ch)")


%% Evolution des cartographies (couple à la roue)

figure
title("Evolution des cartographies (couple à la roue)");
grid on
hold on
plot(RPM_21,Croue_21) %v1.3 session 2
plot(RPM_25,Croue_25) %v2.0 session 2
plot(RPM_27,Croue_27) %v2.1 session 2
plot(RPM_28,Croue_28) %v2.2 session 2
plot(RPM_32,Croue_32) %v3.0 session 3
plot(RPM_35,Croue_35) %v3.4 session 3
legend("v1.3","v2.0","v2.1","v2.2","v3.0","v3.4")
xlabel("RPM (tr/min)")
ylabel("Couple à la roue (N.m)")

%% Evolution des cartographies (Puissance moteur)

figure
title("Evolution des cartographies (Puissance moteur)");
grid on
hold on
plot(RPM_21,Pengine_21) %v1.3 session 2
plot(RPM_24,Pengine_24) %v2.0 session 2
plot(RPM_32,Pengine_32) %v3.0 session 3
plot(RPM_35,Pengine_35) %v3.4 session 3
legend("v1.3","v2.0","v3.0","v3.4")
xlabel("RPM (tr/min)")
ylabel("Puissance moteur (ch)")

%% Courbes de puissance

figure
title("Courbe de puissance moteur");
grid on
hold on
plot(RPM_35,Pengine_35) %v3.4 session 3
xlabel("RPM (tr/min)")
ylabel("Puissance moteur (ch)")

%% Courbes de couple

figure
title("Courbe de couple moteur");
grid on
hold on
plot(RPM_35,Cengine_35) %v3.4 session 3
xlabel("RPM (tr/min)")
ylabel("Couple moteur (N.m)")

%% Courbe d'évolution puissance moteur
c = 0.9; %coefficient rectificateur (mauvais calcul des pertes moteur)

figure
title("Evolution des puissances et couples moteur");
grid on
hold on

yyaxis left
plot(RPM_21(10:end),Pengine_21(10:end)*c,'b-') %v1.3 session 2
plot(RPM_35,Pengine_35,'r-') %v3.4 session 3
ylabel("Puissance moteur (ch)")

yyaxis right
plot(RPM_21(10:end),Cengine_21(10:end)*c,'b--') %v1.3 session 2
plot(RPM_35,Cengine_35,'r--') %v3.4 session 3
ylabel("Couple moteur (N.m)")
ylim([0 100])

xlabel("RPM (tr/min)")
legend("Puissance v1.3","Puissance v3.4", "Couple v1.3", "Couple v3.4","Location","northwest")

%% Bac à sable

figure
grid on
hold on
%plot(RPM_11,Pengine_11) %v1.3 session 1
%plot(RPM_12,Pengine_12) %v1.3 session 1
%plot(RPM_21,Pengine_21) %v1.3 session 2
%plot(RPM_22,Proue_22) %v1.3 session 2
%plot(RPM_23,Proue_23) %v1.3 session 2
%plot(RPM_24,Proue_24) %v2.0 session 2
plot(RPM_25,Proue_25) %v2.0 session 2
%plot(RPM_26,Proue_26) %v2.1 session 2
plot(RPM_27,Proue_27) %v2.1 session 2
plot(RPM_28,Proue_28) %v2.2 session 2
plot(RPM_29,Proue_29) %v3.0 session 2
%plot(RPM_210,Proue_210) %v3.0 session 2
%plot(RPM_31,Proue_31) %v3.0 session 3
%plot(RPM_32,Proue_32) %v3.0 session 3
%plot(RPM_33,Proue_33) %v3.0 session 3
%plot(RPM_34,Proue_34) %v3.0 session 3
plot(RPM_35,Proue_35) %v3.4 session 3
%plot(RPM_36,Proue_36) %v3.4 session 3
xlabel("RPM (tr/min)")
ylabel("Puissance (ch)/Couple (N.m)")
legend("v2.0","v2.1","v2.2","v3.0","v3.4")
