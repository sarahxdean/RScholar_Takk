% reads data from files
function [] = concatmultiplot (s)


figure(1)
for i = 1:8
  subplot(2,4,i) 
  hold on
  title(num2str(i-1))
  plot(s(:,41),s(:,i),'.')
  plot(s(:,41),s(:,i))
  hold off
end

figure(2)
for i = 1:8
  subplot(2,4,i) 
  hold on
  title(num2str(i+7))
  plot(s(:,41),s(:,i+8),'.')
  plot(s(:,41),s(:,i+8))
  hold off
end

figure(3)
for i = 1:8
  subplot(2,4,i) 
  hold on
  title(num2str(i+15))
  plot(s(:,41),s(:,i+16),'.')
  plot(s(:,41),s(:,i+16))
  hold off
end

figure(4)
for i = 1:8
  subplot(2,4,i) 
  hold on
  title(num2str(i+31))
  plot(s(:,41),s(:,i+32),'.')
  plot(s(:,41),s(:,i+32))
  hold off
end

%subplot(2,4,2)
%hold on
%plot(s.s1,'.')
%plot(s.s1)
%hold off