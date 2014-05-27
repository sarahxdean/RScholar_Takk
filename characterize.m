
data = zeros(1,82);

while(1)
    c = input('> ','s');
        if (strcmp(c, 'quit'))
            save('char/datarun.txt','data','-ascii','-tabs');
                break
        else
                tline1 = python('TakktoMatlab.py','7');
                a1 = str2num(tline1);
                force = input('enter force: ');
                sensor = input('enter sensor number: ');
                a = horzcat(a1, force, sensor);
                data = vertcat(data,a)
        end
end