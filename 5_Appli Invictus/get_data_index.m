function index = get_data_index(data_struct,name)
    s = size(data_struct);
    n= s(2); %s(2) correspond au nombre de noms de donn�s
    index = NaN;
    for k=1:n
        if strcmp(data_struct(k).Name,name) %Compare si les deux string sont �gaux
            index = k;
        end
    end
end