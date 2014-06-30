data = rdata(7:end,:);
CoM(:,1) = pendCoMx(data(:,81));

%incorporate baseline
baseline = mean(rdata(1:6,:)); %6 depends on specific cases


    x = [4.76 2.38 4.76 2.38 4.76 10.76 8.38 10.76 8.38 10.76 16.76 14.38 16.76 14.38 16.76 22.76 20.38 22.76 20.38 22.76 28.76 26.38 28.76 26.38 28.76 34.76 32.38 34.76 32.38 34.76 40.76 38.38 40.76 38.38 40.76 46.76 44.38 46.76 44.38 46.76] - 24.808;
    y = [27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3] - 15;

%two ways: linear combo of sensors = CoM or give the system more structure

%giving it more structure -- returns all 0!!
observed(1,:) = x - sum(x)/length(x);
observed(2,:) = y - sum(y)/length(y);

for i=1:length(data(:,1))
    observed(i+2,:) = data(i,1:40) .* (x - CoM(i,1));
    observed(i+2+length(data(:,1)),:) = data(i,1:40) .* (y - 0);%CoM(i,2));
end
h = zeros(2*length(data(:,1))+2,1);
weight = lsqlin(observed,h,[],[],[],[],zeros(length(data(:,1)),1)+0.001,[]);



%plot what i've seen
h(:,2) = observed*weight
