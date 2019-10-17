function [alpha_int, alpha_ext] = lien_angle_rack(angle_volant, car)

% Angle_volant est en degré, définie aritrairement positif si il est tourné
% dans le sens trigonométrique
% alpha_int : en deg, angle de la roue intérieure et positif pour un angle
% de volant positif
% alpha_ext : en deg, angle de la roue exterieure et positif pour un angle
% de volant positif

spr = car.spr; % mm/rev speed ratio, donnée par formula seven
tr = car.tr; %mm, Voie de la voiture
Lc = car.Lc; %mm, Longueur de la crémaillère
b = car.b; % mm, longueur du bras de levier dans le PM
Lb = car.Lb; %mm, Longueur de la biellette de direction
h = car.h; %mm, Distance entre l'axe des roues avant et la crémaillère

angle_volant = angle_volant / 360; % Pour avoir l'angle du volant en tour
lambda = angle_volant*spr; % En mm, déplacement de la crémaillère 

f = @(lambda) lambda - tr/2 + Lc/2;
g = @(lambda) (f(lambda).^2 + b^2 - Lb^2 + h^2) / (2*b);

alpha_0 = asin(g(0) ./ sqrt(f(0).^2 + h^2)) + acos(h ./ sqrt(f(0).^2 + h^2));

alpha_int_ini = asin(g(lambda) ./ sqrt(f(lambda).^2 + h^2)) + acos(h ./ sqrt(f(lambda).^2 + h^2)) - alpha_0;
alpha_ext_ini = asin(g(-lambda) ./ sqrt(f(-lambda).^2 + h^2)) + acos(h ./ sqrt(f(-lambda).^2 + h^2)) - alpha_0;

alpha_int_ini = alpha_int_ini*180/pi;
alpha_ext_ini = alpha_ext_ini*180/pi;

if angle_volant >= 0
    alpha_int = abs(alpha_int_ini);
    alpha_ext = abs(alpha_ext_ini);
else
    alpha_int = - abs(alpha_ext_ini);
    alpha_ext = - abs(alpha_int_ini);
    
end

end