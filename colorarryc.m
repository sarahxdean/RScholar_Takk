%/**************************************************************************/

%@author sarah
%@license BSD

%Matlab example to capture data from the Arduino which is connected to the TakkTile Strip sensor
%optimized for use

%@section NOTES
% inspired partially by the code of Erin, the RobotGrrl 
% from http://robotgrrl.com/blog/2010/01/15/arduino-to-matlab-read-in-sensor-data/
%/**************************************************************************/

clear all; close all;

%%

[a,b,c,d] = importcoeffile('char/calibcoef.csv',2, 41);
a = a.';
b = b .';
c = c.';
d = d.';

x = [1:9];

y = [1:6];

[X,Y] = meshgrid(x,y);

%use the user defined colormap for figure.
%set the color limits
hold on
caxis manual 
caxis([-5 10])
caxis(caxis)
colormap(autumn);

try
     lHandle = line(nan,nan);
for i=1:10000
        tline1 = python('TakktoMatlab.py','7');

% ------
        
        data = str2num(tline1);
        p = data(1:40);
        t = data(41:80);
        p = a + b .* p + c .* t + d .* p .* t;
        b1 = reshape(p, 5, 8);
        b2 = [flipud(b1), zeros(5,1)];
        Z = [b2; zeros(1,9)]
                
        pcolor(X,Y,Z);
        ct = arrayCoM(p);
        
        cm(1) = ct(1) * 8 / 49.2125;
        cm(2) = ct(2) * 5 / 28.575;
        
        %[18 15] [-10 -10]
        if ((cm(1) < 11) && (cm(1) > -1) && (cm(2) < 6) && (cm(2) > -1) )
            plot(cm(1)+1,cm(2)+1,'*')
        else 
            %a(1:40)
            %c
        end
        
        

%set the x and y labels

    set(gca,'XTick',[1 2 3 4 5 6 7 8 9],'YTick',[1 2 3 4 5 6],'XTicklabel',[' ';'1';'2'; '3'; '4';'5';'6';'7';'8'],'YTicklabel',[' ';'1';'2';'3';'4';'5']);
   
    drawnow 

     

end
%% ----

catch err
%        rethrow(err);
    err
end

%% --