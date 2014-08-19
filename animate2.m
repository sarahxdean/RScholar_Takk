
figure(1)
filename = 'testnew51.gif';
for i = 1:23
      
      visualizeFeet2(1,transpose( data(i,1:40,2)-data(i,1:40,1) ),'m',0,200)
      %visualizeFeet(1,transpose( baseline(i,1:40,2)-data(i,1:40,1) ),'m','Force')
      drawnow
      frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if i == 1;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          imwrite(imind,cm,filename,'gif','WriteMode','append');
      end
end