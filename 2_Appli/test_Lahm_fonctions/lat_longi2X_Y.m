function [X,Y] = lat_longi2X_Y(lattitude, longitude)
% lattitude et longitude sont les données brut en ° venant des logs

lat_red = (lattitude - mean(lattitude))*pi/180;
long_red = (longitude - mean(longitude))*pi/180;

R = 6378137; % Rayon standard de la terre

X = R .* tan(lat_red);
Y = R .* tan(long_red);

end