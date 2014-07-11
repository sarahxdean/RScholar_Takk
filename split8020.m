function [train,test] = split8020(data)

d = data(randperm(length(data(:,1))),:);

sp = round(0.8 * length(data(:,1)));

train = d(1:sp,:);
test = d(sp+1:end,:);

end