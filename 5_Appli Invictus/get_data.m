function data = get_data(data_struct,name)
    index = strcmp({data_struct.Name}, name)==1;
    data = data_struct(index).Data;
end

