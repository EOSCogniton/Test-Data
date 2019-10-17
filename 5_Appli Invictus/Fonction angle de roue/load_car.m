function [car] = load_car(car_name)

% Fonction permettant de charger les données de la voiture
% car_name est un string, le nom de la voiture sans la fin du fichier
% Car est une structure

[num,txt,raw] = xlsread(strcat(car_name,'.xlsx'), 'matlab');

car = struct;

for i=1:length(raw)
    car.((string(raw(1,i)))) = cell2mat(raw(2,i));
end

end