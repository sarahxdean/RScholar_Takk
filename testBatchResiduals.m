%residuals from the test batch
CoMx = pendCoMx(test1(:,81)); 
%CoM(:,2) = zeroes(length(CoM(:,1),1);
CoMy = pendCoMy(test2(:,82)); %y data eventually

baselinex = mean(rdata1(1:6,:)); %6 depends on specific cases
baseliney = mean(rdata2(1:6,:));

x = [4.76 2.38 4.76 2.38 4.76 10.76 8.38 10.76 8.38 10.76 16.76 14.38 16.76 14.38 16.76 22.76 20.38 22.76 20.38 22.76 28.76 26.38 28.76 26.38 28.76 34.76 32.38 34.76 32.38 34.76 40.76 38.38 40.76 38.38 40.76 46.76 44.38 46.76 44.38 46.76] - 24.808;
y = [27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3] - 15;

for i=1:length(test1(:,1))
    observedt(i,:) = (test1(i,1:40)-baselinex(1:40)) .* x;
    ht(i,:) = CoMx(i);
end

for i=1:length(test2(:,1))
    observedt(i+length(test1(:,1)),:) = (test2(i,1:40)-baseliney(1:40)) .* y;
    ht(i+length(test1(:,1)),:) = CoMy(i); %more versatile for Y 
end

ht(:,2) = observedt*weight;
ht(:,1)-ht(:,2)