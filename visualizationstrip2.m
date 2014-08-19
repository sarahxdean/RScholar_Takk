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

try
     lHandle = line(nan,nan);
     set(lHandle, 'XData', zeros(1,100), 'YData', zeros(1,100));
     drawnow
     for i=1:10000
        [tmp,d] = system('../DXL_SDK_LINUX_v1_01/example/InvPendContr/striptoMatlab.o');

% ------
        %a=strread(ss,'%s','delimiter', ',');
        a = str2num(d);

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
    toplot = a(25)
        % TODO: the plotting works, but slows down the whole system ... 

    X = get(lHandle, 'XData');
    Y = get(lHandle, 'YData');

    %if (X.size() > 100)
     %   X = X(2:X.size());
     %   Y = Y(2:Y.size());
    %end
    
    X = [X(2:100) i];
    Y = [Y(2:100) toplot];

    set(lHandle, 'XData', X, 'YData', Y);
    drawnow

     

end
%% ----

catch err
%        rethrow(err);
    err
end

%% --