function [array] = reshapeArray(data)

b1 = reshape(data(1:40), 5, 8);
b2 = [flipud(b1), zeros(5,1)];
array = [b2; zeros(1,9)];



end