%average by angle - have an array of avg sensor readings by angle
odata = trial612a;
len = size(odata,1);
if (mod(len, 10) ~= 0)
    %error
    error = 1
end

adata = zeros(len/10,81);

for i=1:(len/10)
    for j=1:10
        adata(i,:) = adata(i,:)+odata(10*(i-1)+j,:);
    end
    adata(i,:) = adata(i,:) ./ 10;
end
% need to subtract off calibration!!!

%method one: use the measured calibration from that day
%acdata=adata;
%for i=2:(len/10)
%    acdata(i,1:80) = adata(i,1:80) - adata(1,1:80);
%end

%method two: use otherwise collected sensitivity data
acdata=adata;
for i=1:(len/10)
    acdata(i,1:40) = (adata(i,1:40) - transpose(p(:,2))) ./ transpose(p(:,1));
end

%find CoM for each angle

CoM = zeros(len/10, 3);

for i=1:(len/10)
    CoM(i,:) = [acdata(i,81) arrayCoM(acdata(i,1:40))];
end

%plot CoM

hold on
caxis manual
caxis([-20 20]);

scatter(CoM(:,2),CoM(:,3),50,CoM(:,1),'fill');
axis([0 42 0 28])
colorbar
hold off

figure(2)
hold on
count=1;
for i=1:len
    if odata(i,81) == 150
        plot(count, odata(i,n),'.')
        count=count+1;
    end
end

hold off
figure(3)
hold on
count=1;
for i=1:(len/10)
    if CoM(i,1) == 150
        plot(count, CoM(i,2),'.')
        count=count+1;
    end
end

hold off
figure(4)
hold on
count=1;
for i=1:(len/10)
    if CoM(i,1) == 150
        plot(count, CoM(i,3),'.')
        count=count+1;
    end
end


%add color?? coded by angle