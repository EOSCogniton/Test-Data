classdef Sensor
    %Définition des objets 'Sensor' pour référencer les capteurs
    properties
        name char; %Nom du capteur
        ref char; %Référence du capteur
        unit char; %Unité
        data; %Données (sous forme de liste)
    end
    methods
        function obj=Sensor(name,ref,unit,data)
            if (nargin>0)
                obj.name = name;
                obj.ref = ref;
                obj.unit = unit;
                obj.data = data;
            end
        end
    end
end