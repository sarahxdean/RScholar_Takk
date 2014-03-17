function [s, t] = readdata (number)

s = dlmread(strcat('data',num2str(number),'.txt'),'\t', 1, 0);
t = dlmread(strcat('temp',num2str(number),'.txt'),'\t', 1, 0);
