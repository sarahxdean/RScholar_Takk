[r_axa ac_axa] = pendCoMmodel(467,556,24.8);
data_axa = parseWeightData(july11axa([1:end],:),6,r_axa,ac_axa,1);

[r_axb ac_axb] = pendCoMmodel(433,578,24.8);
data_axb = parseWeightData(july11axb([1:19 21:end],:),6,r_axb,ac_axb,1);

[r_axc ac_axc] = pendCoMmodel(580,546,24.8);
data_axc = parseWeightData(july11axc([1:end],:),6,r_axc,ac_axc,1);


data_standardx = data_axa;
data_lightx = data_axb;
data_heavyx = data_axc;

[r_aya ac_aya] = pendCoMmodel(491,535,14.1);
data_aya = parseWeightData(july11aya([1:end],:),6,r_aya,ac_aya,1);

[r_ayb ac_ayb] = pendCoMmodel(474,551,14.1);
data_ayb = parseWeightData(july11ayb([1:end],:),6,r_ayb,ac_ayb,1);

[r_ayc ac_ayc] = pendCoMmodel(501,532,14.1);
data_ayc = parseWeightData(july11ayc([1:end],:),6,r_ayc,ac_ayc,1);

[r_ayd ac_ayd] = pendCoMmodel(491,536,14.1);
data_ayd = parseWeightData(july11ayd([1:end],:),6,r_ayd,ac_ayd,1);


data_standardy = cat(1,data_aya,data_ayd);
data_lighty = data_ayb;
data_heavyy = data_ayc;

