close all;
clear all;

dist_total_cap = 0;
for k = 1:4
    filename = sprintf('Log Valbonne 02 04 - EE%d.Dat',k);
    T = readtable(filename); 
    
    N = height(T);
    
    lusp = str2double(strrep(table2array(T(1:N,9)),',','.')).*(1.55/2/3.14);
    dist_a = trapz(linspace(0,0.1*(N-1),N),lusp)
    
    
    dist_total_cap = dist_total_cap + dist_a;
end

dist_total = dist_total_cap/1000
