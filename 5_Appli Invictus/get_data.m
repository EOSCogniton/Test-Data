function data = get_data(data_struct,name)
    s = size(data_struct);
    n= s(2); %s(2) correspond au nombre de noms de donnés
    index = NaN;
    for k=1:n
        if strcmp(data_struct(k).Name,name) %Compare si les deux string sont égaux
            index = k;
        end
    end
    data = data_struct(index);
end

