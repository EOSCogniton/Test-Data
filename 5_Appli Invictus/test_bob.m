struct = log2struct_Bob('C:\Users\bobau\Documents\EPSA\Test-Data\5_Appli Invictus\données test\rc_33.log');

% Function  ExportdatatotheworkspaceButtonPushed
for i=1:numel(struct) %On parcour toute la tructure
    if ~isempty(struct(i).Name) % si c'est non vide (entre 50 et 100 par exemple)
    assignin('base',struct(i).Name,struct(i).Data);
    end
end

%Test ploXY
ax = axes();
plotXY(struct,'TPS','Injection',ax)




function []=plotXY(struct,NameX,NameY,Axis) %Fonction pour un plot X, Y ne marche pour ploter en fonction du temps

id1 = find(strcmp({struct.Name}, NameX)==1); %on récupère l'indice des voie à ploter
id2 = find(strcmp({struct.Name}, NameY)==1);

if struct(id1).Frequency == struct(id2).Frequency %Si les voies on été enregistrées à la même fréquence on affiche normal
    
    plot(Axis,struct(id1).Data , struct(id2).Data,'*','DisplayName',char(strcat(NameY,{' in '},struct(id2).Unit)));

else %Sinon on interpolle sur la période des X
    
    P1 = strcat('P',num2str(struct(id1).Frequency)); %le nom des temps pour les bonnes fréquences 
    P2 = strcat('P',num2str(struct(id2).Frequency));
    idP1 = strcmp({struct.Name}, P1)==1; %les listes des temps pour les bonnes fréquences 
    idP2 = strcmp({struct.Name}, P2)==1;
    
    Y = interp1(struct(idP2).Data,struct(id2).Data,struct(idP1).Data); %Interpolation
    
    plot(Axis,struct(id1).Data , Y,'*','DisplayName',char(strcat(NameY,{' in '},struct(id2).Unit))); %On plot
    
end

xlabel(strcat(NameX,{' in '},struct(id1).Unit)); 
legend('location','best')

end