function [eq] = correlation(s,t)

eq = zeros(2,40);

for i = 1:40
    eq(:,i) = polyfit(t(:,i),s(:,i),1);
end