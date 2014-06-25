tline1 = python('TakktoMatlab.py','7')
data = str2num(tline1);
p = data(1:40)-base(1:40);
ct = arrayCoM(p)