clear all;
close all;

dist_total_cap = 0;
for k = 0:8
    filename = sprintf('rc_%d.log',k);
    T = readtable(filename); 
    
    N = height(T);
    
    acc_x = table2array(T(1:end,10));
    dist_x = cumtrapz(linspace(0,0.04*(N-1),N),acc_x - mean(acc_x));
    dist_x = cumtrapz(linspace(0,0.04*(N-1),N),dist_x);

    acc_y = table2array(T(1:end,11));
    dist_y = cumtrapz(linspace(0,0.04*(N-1),N),acc_y - mean(acc_y));
    dist_y = cumtrapz(linspace(0,0.04*(N-1),N),dist_y);

    dist_step = 0;
    for i= 1 : N -1 
        dist_step = dist_step + sqrt((dist_x(i)-dist_x(i+1))^2 +(dist_y(i)-dist_y(i+1))^2 );
    end
    fprintf('Distance %d\n',k);
    distance = dist_step/1000
    
   dist_total_cap = dist_total_cap + dist_step;
end

dist_total_cap = dist_total_cap/1000