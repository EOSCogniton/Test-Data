function index = getDataIndex(str)
    s = size(struct);
    n= s(2);
    for k=1:n
        if struct(k).Name == str
            index = k;
        end
    end
end