function [trSensorPos]  = TransformSensorPos(sensorPos)

%trMatrix = TransformImage([34 112],[13 443],[845 431],[825 121],40.2,99.8);
trMatrix = TransformImage([83 15],[81 242],[489 243],[482 12],28.9,49.4);

for i = 1:length(sensorPos(:,1))
    w = [sensorPos(i,:) 1]*trMatrix(:,3);
    trSensorPos(i,:) = [sensorPos(i,:) 1] * trMatrix / w;
end

CoM = sum(trSensorPos)/length(sensorPos(:,1))

for i = 1:length(sensorPos(:,1))
    trSensorPos(i,:) = trSensorPos(i,:) - CoM;
end

trSensorPos = trSensorPos(:,1:2);

end