
data = zeros(1,81);

while(1)
    c = input('> ','s');
        if (strcmp(c, 'quit') || strcmp(c, 'q'))
            data = data(2:end,:);
            s = input('enter file name: ','s');
            save(strcat('char/',s,'.txt'),'data','-ascii','-tabs');
                break
        else
                [tmp,d] = system('../DXL_SDK_LINUX_v1_01/example/InvPendContr/getData.o');
                d
                %a1=zeros(1,80);
                %for i=1:10
                 %   tline1 = python('TakktoMatlab.py','7');
                  %  a1 = a1 + str2num(tline1);
                %end
                %a1 = a1 ./10;
                a1 = str2num(d);
                data = vertcat(data,a1);
        end
end