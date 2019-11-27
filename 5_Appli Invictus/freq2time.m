function TF = freq2time(data_struct,freq)%Fonction permettant de g�n�rer une liste de temps � la fr�quence F
    Utc = get_data(data_struct, 'Utc');
    Utc_freq = 50;
    step = Utc_freq/freq;
    n = numel(Utc)/step;
    TF=[];
    for i=1:n
        TF = [TF Utc(i*step)];
    end
end

