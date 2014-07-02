%/**************************************************************************/

%@author sarah
%@license BSD

%Matlab example to capture data from the Arduino which is connected to the TakkTile Strip sensor
%optimized for use

%@section NOTES
% inspired partially by the code of Erin, the RobotGrrl 
% from http://robotgrrl.com/blog/2010/01/15/arduino-to-matlab-read-in-sensor-data/

%assumes that base already exists. must do base=baseline() before running

%/**************************************************************************/

close all;

%%

x = [1:9];

y = [1:6];

[X,Y] = meshgrid(x,y);

%use the user defined colormap for figure.
%set the color limits
hold on
caxis manual 
caxis([-400 10])
caxis(caxis)
colormap(autumn);

try
     lHandle = line(nan,nan);
for i=1:10000
        tline1 = python('TakktoMatlab.py','7');

% ------
        
        a = str2num(tline1);
        a = a - base;
        %b1 = reshape(a(1:40), 5, 8);
        %b2 = [flipud(b1), zeros(5,1)];
        %Z = [b2; zeros(1,9)];
        Z = reshapeArray(a)
                
        pcolor(X,Y,Z);
        ct = arrayCoM(a(1:40));
        
        c(1) = ct(1) * 8 / 49.2125;
        c(2) = ct(2) * 5 / 28.575;
        
        %[18 15] [-10 -10]
        if ((c(1) < 11) && (c(1) > -1) && (c(2) < 6) && (c(2) > -1) )
            plot(c(1)+1,c(2)+1,'*')
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