function index = get_data_index(data_struct,str)
    s = size(data_struct);
    n= s(2);
    index = NaN;
    for k=1:n
        if data_struct(k).Name == str
            index = k;
        end
    end
end