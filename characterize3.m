
data = zeros(1,82);
count = start; %must have a variable called start
cntf = 0;

while(1) 
    c = input(strcat(num2str(count),' >'),'s');
        if (strcmp(c, 'quit') || strcmp(c, 'q'))
            data = data(2:end,:);
            s = input('enter file name: ','s');
            save(strcat('char/',s,'.txt'),'data','-ascii','-tabs');
                break
        else
                [tmp,force] = system('ruby ../LabPro/freelab/force2');
                %a1=zeros(1,80);
                %for i=1:10
                 %   tline1 = python('TakktoMatlab.py','7');
                  %  a1 = a1 + str2num(tline1);
                %end
                %a1 = a1 ./10;
                tline1 = python('TakktoMatlab10.py','7');
                a1 = str2num(tline1) ./ 10;

                a = horzcat(a1, str2num(force),count)
                data = vertcat(data,a);
                cntf = cntf + 1;
                if(cntf == 5)
                    count = count + 1;
                    cntf = 0;
                end
        end
end