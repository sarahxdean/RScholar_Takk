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

% s = serial('COM5'); % for windows
s = serial('/dev/ttyACM0'); % for ubuntu

set(s,'Baudrate',115200);
set(s,'DataBits', 8);
set(s,'StopBits', 1);
fopen(s)
s.ReadAsyncMode = 'continuous';

% Start asynchronous reading
readasync(s);

%%
figure(1)
try
    subplot(5, 1, 1);
     lHandle1 = line(nan,nan);
    subplot(5, 1, 2);
     lHandle2 = line(nan,nan);
     subplot(5, 1, 3);
     lHandle3 = line(nan,nan);
    subplot(5, 1, 4);
     lHandle4 = line(nan,nan);
     subplot(5, 1, 5);
     lHandle5 = line(nan,nan);
for i=1:10000
        tline1 = fscanf(s, '%s');
        ss=tline1(2:end-1); % remove the outside brackets

% ------
        %a=strread(ss,'%s','delimiter', ',');
        a = str2num(ss);

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
    a(1)
        % TODO: the plotting works, but slows down the whole system ... 

    X1 = get(lHandle1, 'XData');
    Y1 = get(lHandle1, 'YData');
    X1 = [X1 i];
    Y1 = [Y1 a(1)];
    set(lHandle1, 'XData', X1, 'YData', Y1);
    
    X2 = get(lHandle2, 'XData');
    Y2 = get(lHandle2, 'YData');
    X2 = [X2 i];
    Y2 = [Y2 a(2)];
    set(lHandle2, 'XData', X2, 'YData', Y2);
    
    X3 = get(lHandle3, 'XData');
    Y3 = get(lHandle3, 'YData');
    X3 = [X3 i];
    Y3 = [Y3 a(3)];
    set(lHandle3, 'XData', X3, 'YData', Y3);
    
    X4 = get(lHandle4, 'XData');
    Y4 = get(lHandle4, 'YData');
    X4 = [X4 i];
    Y4 = [Y4 a(4)];
    set(lHandle4, 'XData', X4, 'YData', Y4);
    
    X5 = get(lHandle5, 'XData');
    Y5 = get(lHandle5, 'YData');
    X5 = [X5 i];
    Y5 = [Y5 a(5)];
    set(lHandle5, 'XData', X5, 'YData', Y5);
    drawnow
    
    
    
    

     

end
%% ----

catch err
%        rethrow(err);
    err
end

%% --
stopasync(s);
fclose(s)