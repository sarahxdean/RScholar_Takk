function [b] = baseline ()

b = str2num(python('TakktoMatlab.py','7'));

for i = 1:50
    b = (b + str2num(python('TakktoMatlab.py','7')))./2;
end