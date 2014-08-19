%change to put the baseline data "behind" the relevant data and group
%together weights so there will always be 3 matrices (three different
%weights


[r_a ac_a] = pendCoMmodel(453,555,24.808); %this will be a little different
data_a = parseWeightData(july7a,6,r_a,ac_a,1); %the 1 indicates array, 6 shows baseline number

[r_b ac_b] = pendCoMmodel(456,553,24.808);
data_b = parseWeightData(july7b,6,r_b,ac_b,1);

[r_c ac_c] = pendCoMmodel(456,554,24.808);
data_c = parseWeightData(july7c([1:6 8:end],:),6,r_c,ac_c,1);

[r_d ac_d] = pendCoMmodel(411,567,24.808);
data_d = parseWeightData(july7d([1:33 35:end],:),6,r_d,ac_d,1);

[r_e ac_e] = pendCoMmodel(468,553,24.808);
data_e = parseWeightData(july7e([1:76 78:end],:),6,r_e,ac_e,1);

[r_f ac_f] = pendCoMmodel(457,549,24.808);
data_f = parseWeightData(july7f,6,r_f,ac_f,1);

data_standard = cat(1,data_a,data_b,data_c,data_f);
data_light = data_d;
data_heavy = data_e;