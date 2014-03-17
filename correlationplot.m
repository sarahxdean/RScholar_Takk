function [] = correlationplot(s,t)

eq = correlation(s,t);

for j = 0:4
  figure(j+1)
  for i = 1:8
    subplot(2,4,i) 
    hold on
    title(num2str(i+8*j))
    plot(t(:,i+8*j),s(:,i+8*j),'.')
    plot(t(:,i+8*j),s(:,i+8*j))
    fplot(@(x)eq(1,i+8*j)*x+eq(2,i+8*j), [min(t(:,i+8*j)) max(t(:,i+8*j))])
    hold off
  end
end

%{
figure(2)
for i = 1:8
  subplot(2,4,i) 
  hold on
  title(num2str(i+7))
  plot(t(:,i),s(:,i+8),'.')
  plot(t(:,i),s(:,i+8))
    fplot(@(x)eq(1,i)*x+eq(2,i), [min(t(:,i)) max(t(:,i))])
  hold off
end

figure(3)
for i = 1:8
  subplot(2,4,i) 
  hold on
  title(num2str(i+15))
  plot(t(:,i),s(:,i+16),'.')
  plot(t(:,i),s(:,i+16))
    fplot(@(x)eq(1,i)*x+eq(2,i), [min(t(:,i)) max(t(:,i))])
  hold off
end

figure(4)
for i = 1:8
  subplot(2,4,i) 
  hold on
  title(num2str(i+31))
  plot(t(:,i),s(:,i+32),'.')
  plot(t(:,i),s(:,i+32))
    fplot(@(x)eq(1,i)*x+eq(2,i), [min(t(:,i)) max(t(:,i))])
    hold off
end
%}