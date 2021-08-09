
function [log_inj_fe,consommation]= model_Conso(log_inj,log_rpm,debit_inj,fe)
% log_inj = log d'injection
% log_rpm = log RPM
% debit_inj = débit injecteur en mL/s
% fe = []fréquence d'échantillonage

%% Traitement

log_tours = tours_moteurs(log_rpm, fe); %tableau avec le nb de tours moteurs parcourus (cummul tours moteur)
log_inj_fe = log_to_inj (log_rpm, log_tours, log_inj); %tableau de temps d'injection rÃ©el Ã  la frÃ©q fe

time_inj = sum(log_inj_fe); %temps d'injection total en ms
consommation = time_inj/1000*debit_inj/1000; %consommation totale en litre
end
%% Fonctions

function tours = tours_moteurs (log_rpm, fe)
N = length(log_rpm);
tours = zeros(1,N);
rps = log_rpm/60/fe;
for k = 2:N
    tours(k) = tours(k-1) + (rps(k-1) + rps(k))/2;
end
end

function inj_fe = log_to_inj (log_rpm, log_tours, log_inj)
N = length(log_rpm);
inj_fe = zeros(1,N);
for k = 2:N
    a = floor(2*log_tours(k-1));
    b = floor(2*log_tours(k));
    inj_fe(k) = (b-a)*(log_inj(k)-0*1.1); %le 1.1 est le temps mort injecteur (à prendre en compte ?)
end
end

%% Version 2 qui marche
function [log_conso,Total_conso(end)]= model_Conso2(log_dist,log_conso)
% log_dist = log de distance parcourue, doit être la distance cumulée (et
% non la distance au tour (colonne 56 pour Invictus

% log_conso = log de consommation tiré du DTA, en L/100km (Colonne 26 pour
% Invictus)

% /!\ CES 2 VARIABLES DOIVENT ETRE A LA MEME FREQUENCE D'ECHANTILLONAGE

%log_inj_fe est remplacé en sortie par log_conso qui donne une bonne
%indication d'à quels endroits du circuit on consomme beaucoup ou non
%% Traitement

Total_conso = cumtrapz(log_dist,log_conso/100); % /100 pour ramener au L/km
%Ici, c'est important d'avoir la même fréquence d'échantillonage sur les 2
%array pour avoir une intégration homogène

%Total_conso(end) est la consommation totale sur le run enregistré
%Total_conso(end)/log_dist(end)*100 est la consommation en L/100km


end