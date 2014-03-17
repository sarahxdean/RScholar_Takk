% reads data from files
function [] = multiplot (s)

for j = 0:4
  figure(j+1)
  for i = 1:8
    subplot(2,4,i) 
    hold on
    title(num2str(i+8*j))
    plot(s(:,i+8*j),'.')
    plot(s(:,i+8*j))
    hold off
  end
end

%{
figure(1)
for i = 1:8
  subplot(2,4,i) 
  hold on
  title(num2str(i-1))
  plot(s(:,i),'.')
  plot(s(:,i))
  hold off
end

figure(2)
for i = 1:8
  subplot(2,4,i) 
  hold on
  title(num2str(i+7))
  plot(s(:,i+8),'.')
  plot(s(:,i+8))
  hold off
end

figure(3)
for i = 1:8
  subplot(2,4,i) 
  hold on
  title(num2str(i+15))
  plot(s(:,i+16),'.')
  plot(s(:,i+16))
  hold off
end

figure(4)
for i = 1:8
  subplot(2,4,i) 
  hold on
  title(num2str(i+31))
  plot(s(:,i+32),'.')
  plot(s(:,i+32))
  hold off
end
%}
%subplot(2,4,2)
%hold on
%plot(s.s1,'.')
%plot(s.s1)
%hold off