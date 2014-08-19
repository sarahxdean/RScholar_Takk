function [] = visualizeFeet(array,toplot,coption,t,act_com,calc_com) %what color and title
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
mn = min(toplot);
mx = max(toplot);
scaled = 1/(mx-mn) * (toplot - mn);

if coption == 'm'
    colors = horzcat(zeros(size(toplot)),scaled,ones(size(toplot)));%/2);
    map=[ones(101,1) 1-transpose( (0:100)/100 ) zeros(101,1)];%/2];
end
if coption == 't'
    colors = horzcat(scaled,scaled,zeros(size(toplot)));%/2);
    map=[1-transpose((0:100)/100) 1-transpose((0:100)/100) ones(101,1)];%/2];
end
if coption == 'b'
    colors = horzcat(scaled/4,scaled,scaled/4);%/2);
    map=[1-transpose( (0:100)/100 )/4 1-transpose( (0:100)/100 ) 1-transpose( (0:100)/100 )/4];%ones(101,1)/2];
end

colors = ones(size(colors)) - colors


hold on
colormap(map);
caxis([mn mx]);
colorbar


hold on

colorbar
scatter(x,y,circsize*1.1,[0 0 0])
scatter(x,y,circsize,colors,'fill')
title(t)
axis([-axisx axisx -axisy axisy]);axis equal

if nargin > 4
    scatter(act_com,0,100,[0 0 0],'fill')
end
if nargin > 5
calc_com
    scatter(calc_com(1),0,100,[0 0 0])%calc_com(2) - plot x and y position
end

%scatter(x,y,400,[1 1 1],'fill')
hold off


%should add  key
end