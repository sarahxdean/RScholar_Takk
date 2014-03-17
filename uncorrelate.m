function [s2] = uncorrelate(s,t)
eq = correlation(s,t);
s2 = zeros(size(s,1),40);
for j = 1:40
    for i = 1:size(s,1)
        s2(i,j) = s(i,j) - eq(1,j) * t(i,j) - eq(2,j);
    end
end