d = chardata7May;
count = zeros(40);

for i = 1:200
    n = d(i,82);
    count(n) = 1 + count(n);
    eval(['s' num2str(n) '(' num2str(count(n)) ')' '= ' num2str(d(i,n))]);
    eval(['t' num2str(n) '(' num2str(count(n)) ')' '= ' num2str(d(i,40+n))]);
    eval(['f' num2str(n) '(' num2str(count(n)) ')' '= ' num2str(d(i,81))]);
end


for j = 0:4
  figure(j+1)
  for i = 1:8
    n = i+8*j;
    subplot(2,4,i) 
    hold on
    title(num2str(n))
    eval(['plot(f' num2str(n) ',s' num2str(n) ',''.'')']);
    hold off
  end
end