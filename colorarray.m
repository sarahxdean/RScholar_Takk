%/**************************************************************************/

%@author sarah
%@license BSD

%Matlab example to capture data from the Arduino which is connected to the TakkTile Strip sensor
%optimized for use

%This is a library for the TakkTile Strip sensor

%@section NOTES
% inspired partially by the code of Erin, the RobotGrrl 
% from http://robotgrrl.com/blog/2010/01/15/arduino-to-matlab-read-in-sensor-data/
%/**************************************************************************/

clear all; close all;

%%
S=sprintf('calibrating...');
disp(S)
base = baseline();

x = [1:9];

y = [1:6];

[X,Y] = meshgrid(x,y);

%use the user defined colormap for figure.
%set the color limits
caxis manual 
caxis([-4 4])
caxis(caxis)
colormap(autumn);

try
     lHandle = line(nan,nan);
for i=1:10000
        tline1 = python('TakktoMatlab.py','7');

% ------
        %a=strread(ss,'%s','delimiter', ',');
        a = str2num(tline1);
        a = a - base;
        b1 = reshape(a(1:40), 5, 8);
        b2 = [flipud(b1), zeros(5,1)];
        Z = [b2; zeros(1,9)]

% TODO: it seems that the code below works faster than the previous line ... to check
%        a={};
 %       n_start=1;
  %      n_stop=0;
%
 %       for n_stop=1:length(ss)
  %          if (ss(n_stop)==',')
   %             a=[a;ss(n_start:(n_stop-1))];
    %            n_start=n_stop+1;
     %       end
      %  end
       % if (n_stop>n_start)
        %    a=[a;ss(n_start:(n_stop))];
        %end
% --------
        
        %tmpStr=char(strn(1));
        %num=str2num(strn(1))
    %a(40)
        % TODO: the plotting works, but slows down the whole system ... 

    %X = get(lHandle, 'XData');
    %Y = get(lHandle, 'YData');

    %X = [X i];
    %Y = [Y a(40)];

    %set(lHandle, 'XData', X, 'YData', Y);
        pcolor(X,Y,Z);

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