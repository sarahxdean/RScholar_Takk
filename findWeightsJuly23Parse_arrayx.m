[r_axa ac_axa] = pendCoMmodel(467,556,21.7,24.8);
data_axa = parseWeightData(july11axa([1:end],:),6,r_axa,ac_axa,0);

[r_axb ac_axb] = pendCoMmodel(433,578,21.7,24.8);
data_axb = parseWeightData(july11axb([1:19 21:end],:),6,r_axb,ac_axb,0);

[r_axc ac_axc] = pendCoMmodel(580,546,21.7,24.8);
data_axc = parseWeightData(july11axc([1:end],:),6,r_axc,ac_axc,0);


data_standard = data_axa;
data_light = data_axb;
data_heavy = data_axc;