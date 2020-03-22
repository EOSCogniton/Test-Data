
function [log_inj_fe,consommation]= model_Conso(log_inj,log_rpm,debit_inj,fe)
% log_inj = log d'injection
% log_rpm = log RPM
% debit_inj = d�bit injecteur en mL/s
% fe = []fr�quence d'�chantillonage

%% Traitement

log_tours = tours_moteurs(log_rpm, fe); %tableau avec le nb de tours moteurs parcourus (cummul tours moteur)
log_inj_fe = log_to_inj (log_rpm, log_tours, log_inj); %tableau de temps d'injection réel à la fréq fe

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
    inj_fe(k) = (b-a)*log_inj(k);
end
end