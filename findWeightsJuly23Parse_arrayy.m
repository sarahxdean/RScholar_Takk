[r_aya ac_aya] = pendCoMmodel(491,535,21.7,14.1);
data_aya = parseWeightData(july11aya([1:end],:),6,r_aya,ac_aya,0);

[r_ayb ac_ayb] = pendCoMmodel(474,551,21.7,14.1);
data_ayb = parseWeightData(july11ayb([1:end],:),6,r_ayb,ac_ayb,0);

[r_ayc ac_ayc] = pendCoMmodel(501,532,21.7,14.1);
data_ayc = parseWeightData(july11ayc([1:end],:),6,r_ayc,ac_ayc,0);

[r_ayd ac_ayd] = pendCoMmodel(491,536,21.7,14.1);
data_ayd = parseWeightData(july11ayd([1:end],:),6,r_ayd,ac_ayd,0);


data_standard = cat(1,data_aya,data_ayd);
data_light = data_ayb;
data_heavy = data_ayc;