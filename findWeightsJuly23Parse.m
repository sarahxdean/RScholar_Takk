rdata_a = [july7a(7:end,1:40) july7a(7:end,81)];
baseline_a = mean(july7a(1:6,1:40));
[r_a ac_a] = pendCoMmodel(453,555,24.808);
data_a = [rdata_a(:,1:40) pendCoM(rdata_a(:,41),r_a,ac_a)];

rdata_b = [july7b(7:end,1:40) july7b(7:end,81)];
baseline_b = mean(july7b(1:6,1:40));
[r_b ac_b] = pendCoMmodel(456,553,24.808);
data_b = [rdata_b(:,1:40) pendCoM(rdata_b(:,41),r_b,ac_b)];

rdata_c = [july7c(8:end,1:40) july7c(8:end,81)];
baseline_c = mean(july7c(1:6,1:40));
[r_c ac_c] = pendCoMmodel(456,554,24.808);
data_c = [rdata_c(:,1:40) pendCoM(rdata_c(:,41),r_c,ac_c)];

rdata_d = [july7d([7:33 35:end],1:40) july7d([7:33 35:end],81)];
baseline_d = mean(july7d(1:6,1:40));
[r_d ac_d] = pendCoMmodel(411,567,24.808);
data_d = [rdata_d(:,1:40) pendCoM(rdata_d(:,41),r_d,ac_d)];

rdata_e = [july7e([7:76 78:end],1:40) july7e([7:76 78:end],81)];
baseline_e = mean(july7e(1:6,1:40));
[r_e ac_e] = pendCoMmodel(468,553,24.808);
data_e = [rdata_e(:,1:40) pendCoM(rdata_e(:,41),r_e,ac_e)];

rdata_f = [july7f(7:end,1:40) july7f(7:end,81)];
baseline_f = mean(july7f(1:6,1:40));
[r_f ac_f] = pendCoMmodel(457,549,24.808);
data_f = [rdata_f(:,1:40) pendCoM(rdata_f(:,41),r_f,ac_f)];
