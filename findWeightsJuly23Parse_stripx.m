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



data_standard = cat(1,data_sxb,data_sxc,data_sxf);
data_light = data_sxd;
data_heavy = data_sxe;