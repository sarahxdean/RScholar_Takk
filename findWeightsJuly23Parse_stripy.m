[r_sya ac_sya] = pendCoMmodel(485,550,21.7,18.5);
data_sya = parseWeightData(july11ya([1:end],:),6,r_sya,ac_sya,0);

[r_syb ac_syb] = pendCoMmodel(486,550,21.7,18.5);
data_syb = parseWeightData(july11yb([1:end],:),6,r_syb,ac_syb,0);

[r_syc ac_syc] = pendCoMmodel(486,551,21.7,18.5);
data_syc = parseWeightData(july11yc([1:end],:),6,r_syc,ac_syc,0);

[r_syd ac_syd] = pendCoMmodel(456,575,21.7,18.5);
data_syd = parseWeightData(july11yd([1:end],:),6,r_syd,ac_syd,0);

[r_sye ac_sye] = pendCoMmodel(484,544,21.7,18.5);
data_sye = parseWeightData(july11ye(1:end,:),6,r_sye,ac_sye,0);

[r_syf ac_syf] = pendCoMmodel(484,552,21.7,18.5);
data_syf = parseWeightData(july11yf([1:end],:),6,r_syf,ac_syf,0);

data_standard = cat(1,data_sya,data_syb,data_syc,data_syf);
data_light = data_syd;
data_heavy = data_sye;