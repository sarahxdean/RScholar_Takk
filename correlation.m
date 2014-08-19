function [eq] = correlation(s,t)

eq = zeros(2,40); %40for array

for i = 1:40 %only for array
    eq(:,i) = polyfit(t(:,i),s(:,i),1);
end