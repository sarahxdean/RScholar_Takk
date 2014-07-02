x = [1:9];

y = [1:6];

[X,Y] = meshgrid(x,y);

hold on
%caxis manual 
%caxis([-400 10])
%caxis(caxis)
colormap(autumn);

Z = reshapeArray(weight);

pcolor(X,Y,Z);

set(gca,'XTick',[1 2 3 4 5 6 7 8 9],'YTick',[1 2 3 4 5 6],'XTicklabel',[' ';'1';'2'; '3'; '4';'5';'6';'7';'8'],'YTicklabel',[' ';'1';'2';'3';'4';'5']);
   
    drawnow 