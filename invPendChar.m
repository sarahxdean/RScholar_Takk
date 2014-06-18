
data = zeros(1,81);
count=0;

while(1)
    c = input('> ','s');
        if (strcmp(c, 'quit') || strcmp(c, 'q'))
            data = data(2:end,:);
            s = input('enter file name: ','s');
            save(strcat('invpend/',s,'.txt'),'data','-ascii','-tabs');
                break
        else
            
            d30 = input('30: ');
            d31 = input('31: ');
            
            ang = 150 - (d30 + 256*d31)*300/1024;
            %calibration indicated by angles of 150 (input 0)
            
            a2 = zeros(10,1);
            for i=1:10
                a2(i) = ang;
            end
            
            a1 = zeros(1,80);
            for i=1:10
                tline1 = python('TakktoMatlab.py','7');
                a1 = vertcat(a1,str2num(tline1));
            end
            
            a3 = [a1(2:11,:) a2];
            data = vertcat(data,a3);
            count = count + 1
        end
end