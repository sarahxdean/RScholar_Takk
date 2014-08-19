function [] = visualizeFeet(array,toplot,coption,mn,mx) %what color and title
if array
    x = arrayXPos;
    y = arrayYPos;
    circsize = 300;
    axisx = 30;
    axisy = 20;
else
    x = stripXPos;
    y = stripYPos;
    circsize = 400;
    axisx = 40;
    axisy = 30;
end
if nargin < 5
    mn = min(toplot);
    mx = max(toplot);
end
scaled = 1/(mx-mn) * (toplot - mn);

if coption == 'm'
    colors = horzcat(zeros(size(toplot)),scaled,ones(size(toplot)));
    %map=[ones(101,1) 1-transpose( (0:100)/100 ) 1-transpose( (0:100)/100 )];%/2];
end
if coption == 't'
    colors = horzcat(scaled,scaled,zeros(size(toplot)));%/2);
    map=[1-transpose((0:100)/100) 1-transpose((0:100)/100) ones(101,1)];%/2];
end
if coption == 'b'
    colors = horzcat(scaled/4,scaled,scaled/4);%/2);
    map=[1-transpose( (0:100)/100 )/4 1-transpose( (0:100)/100 ) 1-transpose( (0:100)/100 )/4];%ones(101,1)/2];
end

colors = ones(size(colors)) - colors;


hold on
%colormap(map);
%caxis([mn mx]);
%colorbar


hold on


scatter(x,y,circsize*1.1,[0 0 0])
scatter(x,y,circsize,colors,'fill')

axis([-axisx axisx -axisy axisy]);axis equal


%    scatter(act_com,0,100,[0 0 0],'fill')

%scatter(x,y,400,[1 1 1],'fill')
hold off


%should add  key
end