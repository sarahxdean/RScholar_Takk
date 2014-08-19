data = rdata(7:end,:); %7 is specific to this case
CoM(:,1) = pendCoMx(data(:,81));
%CoM(:,2) = zeroes(length(CoM(:,1),1);
CoM(:,2) = pendCoMx(data(:,82)); %y data eventually

%incorporate baseline
baseline = mean(rdata(1:6,:)); %6 depends on specific cases


x = [4.76 2.38 4.76 2.38 4.76 10.76 8.38 10.76 8.38 10.76 16.76 14.38 16.76 14.38 16.76 22.76 20.38 22.76 20.38 22.76 28.76 26.38 28.76 26.38 28.76 34.76 32.38 34.76 32.38 34.76 40.76 38.38 40.76 38.38 40.76 46.76 44.38 46.76 44.38 46.76] - 24.808;
y = [27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3] - 15;

%two ways: linear combo of sensors = CoM or give the system more structure

%giving it more structure -- returns all 0!!
%observed(1,:) = x - sum(x)/length(x);
%observed(2,:) = y - sum(y)/length(y);
%for i=1:length(data(:,1))
%    observed(i+2,:) = data(i,1:40) .* (x - CoM(i,1));
%end
%observed(#+2+length(data),:) = data(#,:) .* (y - CoM(#,2));
%h = zeros(length(data(:,1))+2,1);
%weight = regress(h,observed);

observed(1,:) = x;
observed(2,:) = y;
h = [0;0];

for i=1:length(data(:,1))
    observed(i+2,:) = (data(i,1:40)-baseline(1:40)) .* x;
    h(i+2,:) = CoM(i,1);
    
    observed(i+2+length(data(:,1)),:) = (data(i,1:40)-baseline(1:40)) .* y;
    h(i+2+length(data(:,1)),:) = CoM(i,2); %more versatile for Y
end

weight = regress(h,observed);

%plot what i've seen
h(:,2) = observed*weight

hold on
axis([-28.8 28.8 -15 15]);
for i=1:length(data(:,1))+2
    plot([h(i,1) h(i,2)], [h(i+length(data(:,1)),1) h(i+length(data(:,1)),2)])
    %plot([h(i,1) h(i,2)], [h(i+length(data(:,1)),1) h(i+length(data(:,1)),2)],'*')
end
hold off
