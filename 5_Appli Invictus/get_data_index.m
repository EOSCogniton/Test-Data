function index = get_data_index(data_struct,name)
    index = find(strcmp({data_struct.Name}, name)==1);
end