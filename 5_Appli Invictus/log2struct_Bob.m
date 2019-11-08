function data_struct = log2struct_Bob(datapath)
%Prend un chemin de fichier .log en argument et renvoie un Structure Array
%avec les données organisées
    fid = fopen(datapath);%ouvre le fichier
    first_Line = fgets(fid);%lit la première ligne
    fclose(fid); % ferme le fichier
    i_v = [1 find(first_Line==',')]; %Liste conetant les indices des virgules avec un 1 ajouté devant
    n = length(i_v); %compte le nombre de colonne
    i_v = [i_v length(first_Line)];
    data = dlmread_empty(datapath,',',1,0,NaN); %MAtrice contenant toutes les valeur numérique du fichier
    data_struct = struct('Name',{},'Frequency',{},'Unit',{},'Data',{},'Min',{},'Max',{});
    
    for k=1:n %on parcours les colonnes
        
        element = first_Line(i_v(k):i_v(k+1)-1); %str de la première ligne k_ième colonne
        i_g = find(element=='"'); % indice des guillemets dans l'élément
        i_s = find(element=='|'); % indice des séparateurs dans l'élément
        
        index = numel(data_struct)+1;
        
        data_struct(index).Name = element(i_g(1)+1:i_g(2)-1);
        data_struct(index).Unit = element(i_g(3)+1:i_g(4)-1); 
        data_struct(index).Min = str2double(element(i_s(2)+1:i_s(3)-1));
        data_struct(index).Max = str2double(element(i_s(3)+1:i_s(4)-1));
        data_struct(index).Frequency = str2double(element(i_s(4)+1:end));
        Pname = strcat('F',num2str(data_struct(index).Frequency));
        
        if index >2 && isempty(find(strcmp({data_struct.Name},Pname)==1,1))
            data_struct(index+1).Name = Pname;
            data_struct(index+1).Unit = 'ms'; 
            data_struct(index+1).Min = 0;
            data_struct(index+1).Max = 0;
            data_struct(index+1).Frequency = str2double(element(i_s(4)+1:end));
            id = strcmp({data_struct.Name}', 'Interval')==1;
            data_struct(index+1).Data = data_struct(id).Data(~isnan(data(:,k)))/1000;
        end
        
        d = data(:,k);
        data_struct(index).Data = d(~isnan(data(:,k)));
        
    end           
end