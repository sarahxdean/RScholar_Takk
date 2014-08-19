%[r_sxa ac_sxa] = pendCoMmodel(450,604,33.9,34.1);
%data_sxa = parseWeightData(july11a([1:62 64:end],:),6,r_sxa,ac_sxa,0);

[r_sxb ac_sxb] = pendCoMmodel(451,605,33.9,34.1);
data_sxb = parseWeightData(july11b([1:16 18:end],:),6,r_sxb,ac_sxb,0);

[r_sxc ac_sxc] = pendCoMmodel(450,605,33.9,34.1);
data_sxc = parseWeightData(july11c([1:38 42:end],:),6,r_sxc,ac_sxc,0);

[r_sxd ac_sxd] = pendCoMmodel(403,664,33.9,34.1);
data_sxd = parseWeightData(july11d([1:62 64:end],:),6,r_sxd,ac_sxd,0);

[r_sxe ac_sxe] = pendCoMmodel(480,577,33.9,34.1);
data_sxe = parseWeightData(july11e(1:end,:),6,r_sxe,ac_sxe,0);

[r_sxf ac_sxf] = pendCoMmodel(456,603,33.9,34.1);
data_sxf = parseWeightData(july11f([1:28 30:end],:),6,r_sxf,ac_sxf,0);

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


data_standardx = cat(1,data_sxb,data_sxc,data_sxf);
data_lightx = data_sxd;
data_heavyx = data_sxe;

data_standardy = cat(1,data_sya,data_syb,data_syc,data_syf);
data_lighty = data_syd;
data_heavyy = data_sye;