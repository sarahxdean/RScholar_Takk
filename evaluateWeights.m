x = [4.76 2.38 4.76 2.38 4.76 10.76 8.38 10.76 8.38 10.76 16.76 14.38 16.76 14.38 16.76 22.76 20.38 22.76 20.38 22.76 28.76 26.38 28.76 26.38 28.76 34.76 32.38 34.76 32.38 34.76 40.76 38.38 40.76 38.38 40.76 46.76 44.38 46.76 44.38 46.76] - 24.808;
count = 0;
CoMx = zeros(1,2);

while(1)
    c = input('> ','s');
        if (strcmp(c, 'quit') || strcmp(c, 'q'))
            break
        else
            
                [tmp,d] = system('../DXL_SDK_LINUX_v1_01/example/InvPendContr/getData.o');
                %d
                %a1=zeros(1,80);
                %for i=1:10
                 %   tline1 = python('TakktoMatlab.py','7');
                  %  a1 = a1 + str2num(tline1);
                %end
                %a1 = a1 ./10;
                a = str2num(d);
            if (count == 0)
                baseline = a;
                count = count + 1;
            else
                CoMx(:,2) = sum(transpose(a(:,1:40)-baseline(:,1:40)) .* weight .* transpose(x));
                CoMx(:,1) = pendCoMx(a(:,81))
            end
        end
end