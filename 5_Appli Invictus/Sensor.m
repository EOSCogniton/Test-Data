classdef Sensor
    %D�finition des objets 'Sensor' pour r�f�rencer les capteurs
    properties
        name char; %Nom du capteur
        ref char; %R�f�rence du capteur
        unit char; %Unit�
        data; %Donn�es (sous forme de liste)
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