function TF = freq2time(data_struct,freq)%Fonction permettant de g�n�rer une liste de temps � la fr�quence F
    Utc = get_data(data_struct, 'Utc');
    T = Utc - Utc(1); %On commence � 0
    Utc_freq = 50; %Fr�quence d'�chantillonage du temps
    step = Utc_freq/freq; %Pas entre chaque valeur que l'on va choisir
    n = numel(T)/step;
    TF=[];
    for i=1:n
        TF = [TF T(i*step)];
    end
    TF = TF/1000; %Pour avoir TF en s
end

