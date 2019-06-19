function [alpha_int_R, alpha_ext_R, alpha_int_F, alpha_ext_F] = get_angles_wheels(angle_volant, alpha_v, R, car)

% angle_volant : (en deg) angle du volant
% alpha_v : (rad) angle de la voiture, negatif si 
% R : (m) rayon du virage
% car : (struct) caractéristiques de la voiture

% alpha_int_R : (deg) Angle de glissement de le roue arrière interieur
% alpha_ext_R : (deg) Angle de glissement de le roue arrière exterieur
% alpha_int_F : (deg) Angle de glissement de le roue avant interieur
% alpha_ext_F : (deg) Angle de glissement de le roue avant exterieur

theta_int_R = @(a) atan(((car.L/2) * cos(a) - (car.tr/2) * sin(a)) ./ (R - (car.tr/2) * (1./cos(a)) - (car.L/2) * sin(a) + tan(a) .* sin(a) *(car.tr/2)));
theta_int_F = @(a) atan(((car.L/2) * cos(a) + (car.tf/2) * sin(a)) ./ (R - cos(a) * (car.tf/2) + (car.L/2) * sin(a)));

theta_ext_R = @(a) atan(((car.L/2) * cos(a) + (car.tr/2) * sin(a)) ./ (R + (car.tr/2) * (1./cos(a)) - (car.L/2) * sin(a) - tan(a) .* sin(a) *(car.tr/2)));
theta_ext_F = @(a) atan(((car.L/2) * cos(a) - (car.tf/2) * sin(a)) ./ (R + (car.tf/2) * (1./cos(a)) + (car.L/2) * sin(a) - tan(a) .* sin(a) *(car.tf/2)));

% determination direct de l'angle de glissement
alpha_int_R = theta_int_R(alpha_v) - alpha_v;
alpha_ext_R = theta_ext_R(alpha_v) - alpha_v;
% Angles des pneus avant necessaire pour simplement suivre la trajectoire sans glissser
alpha_geo_int = theta_int_F(alpha_v) + alpha_v;
alpha_geo_ext = theta_ext_F(alpha_v) + alpha_v;
alpha_geo_int*180/pi;
alpha_geo_ext*180/pi;

[alpha_steer_int, alpha_steer_ext] = lien_angle_rack(angle_volant, car);

% Calcul du glissement des pneus avant
alpha_int_F = alpha_steer_int*pi/180 - alpha_geo_int;
alpha_ext_F = alpha_steer_ext*pi/180 - alpha_geo_ext;

% Conversion en deg
alpha_int_R = alpha_int_R *180/pi;
alpha_ext_R = alpha_ext_R *180/pi;
alpha_int_F = alpha_int_F *180/pi;
alpha_ext_F = alpha_ext_F *180/pi;