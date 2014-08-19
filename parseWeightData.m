function [parsed] = parseWeightData(dataFile,num,r,ac,array)
%must disclude cols from datafile if necessary

if array
    ns = 40;
    f = 1;
else
    ns = 25;
    f = -1;
end

rdata = [dataFile(num+1:end,1:ns) dataFile(num+1:end,81)]; %note:angle is always pos 81
baseline = mean(dataFile(1:num,1:ns));
jdata = [rdata(:,1:ns) f*pendCoM(rdata(:,ns+1),r,ac)];
baseline_matrix = [ones(size(rdata)-[0 1])*diag(baseline) zeros(size(rdata,1),1)]; %repeats baseline over and over plus col of 0s
parsed = cat(3,jdata,baseline_matrix);

end