clear all;
close all;

Table = readtable('/Users/bacs/Documents (non iCloud)/EPSA (non iCloud)/Test-Data/7_Invictus/Session roulage Fiabilite - Transpolis 09 04 21/DTA/Transpolis 09 04 21 - Run 4 MJT.Dat');
%% 
carte_MAP = [10 17 25 32 39 47 54 61 68 76 83 90 98 105];
carte_rpm = [1000 1500 2500 3000 3500 4000 5000 6000 7000 8000 8500 9000 9500 10000 10500 11000 11500 12000 13000 14000];

rpm = table2array(Table(1:end,3));
MAP = table2array(Table(1:end,7));
N = length(rpm);

nMAP = 14;
nrpm = 20;

parcours = zeros(nrpm, nMAP);
compteur = 0;

for l = 1:N
    a = rpm(l);
    b = MAP(l);
    for i = 2:nrpm
        if (carte_rpm(i-1) <= a) && (a < carte_rpm(i))
            for j = 2:nMAP
                if (carte_MAP(j-1) <= b) && (b < carte_MAP(j))
                    parcours(i,j) = parcours(i,j) + 1;
                    compteur = compteur + 1;
                end
            end
        end
    end
end
surf(carte_MAP,carte_rpm,parcours)

            
