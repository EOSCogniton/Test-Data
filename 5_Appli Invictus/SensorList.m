classdef SensorList
    %Classe g�rant la liste des capteurs
    properties
        sensors = [];
    end
    methods
        
        function obj = SensorList
            obj.sensors=[];
        end
        
        function requested_sensor = getSensorFromRef(obj,ref)
            %Renvoie un objet 'Sensor' � partir d'une r�f�rence
            for sensor=obj.sensors
                if sensor.ref == ref
                    requested_sensor = sensor;
                end
            end
        end
        
        function obj=addSensor(obj,name, ref, unit, data)
            %Fonction renvoyant un objet 'Sensor' et l'ajoute � la liste
            %des capteurs
            
            sensor = Sensor(name,ref,unit,data);
            obj.sensors = [obj.sensors, sensor];
            
        end
        
    end
end