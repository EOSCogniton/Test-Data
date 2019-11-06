function data_struct = log2struct(datapath)
%Prend un chemin de fichier .log en argument et renvoie un Structure Array
%avec les données organisées
    fid = fopen(datapath);%ouvre le fichier
    first_Line = fgets(fid);%lit la première ligne
    fclose(fid); % ferme le fichier
    i_v = [1 find(first_Line==',')]; %Liste contenant les indices des virgules avec un 1 ajouté devant
    n = length(i_v); %compte le nombre de colonne
    i_v = [i_v length(first_Line)];
    data = dlmread_empty(datapath,',',1,0,NaN); %MAtrice contenant toutes les valeur numérique du fichier
    for k=1:n %on parcours les colonnes
        element = first_Line(i_v(k):i_v(k+1)-1); %str de la première ligne k_ième colonne
        i_g = find(element=='"'); % indice des guillemets dans l'élément
        i_s = find(element=='|'); % indice des séparateurs dans l'élément
        data_struct(k).Name = element(i_g(1)+1:i_g(2)-1)  ;
        data_struct(k).Unit = element(i_g(3)+1:i_g(4)-1); 
        data_struct(k).Min = str2double(element(i_s(2)+1:i_s(3)-1));
        data_struct(k).Max = str2double(element(i_s(3)+1:i_s(4)-1));
        data_struct(k).Period = str2double(element(i_s(4)+1:end));
        data_struct(k).Data = data(:,k);
    end
end