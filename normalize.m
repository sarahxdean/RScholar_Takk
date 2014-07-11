function [normed] = normalize(data)

total = sum(data,2);

matrix = diag(total)*ones(size(data));

normed = data ./ matrix;

end