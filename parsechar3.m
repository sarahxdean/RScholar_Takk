data = zeros(5,81,40); %assumes 5 trials for each
count = zeros(40);
z = zeros(1,81);
countz = 0;

%makes 3d array to encode postion - (trial, data, position)

for i = 1:length(filedata(:,1))
   n = filedata(i, 82);
   if (n ~= 0)
       count(n) = count(n) + 1;
       data(count(n),:,n) = filedata(i,1:81);
   else
        z = z + filedata(i,1:81);
        countz = countz + 1;
   end
end

z = z ./ countz; %each sensor has a zero at z(i) - z(81) for vernier

% for ith position, plot vernier vs. ith sensor (minus the zero number) 

for i = 1:40
    figure(i)
    appliedf = [0;data(:,81,i)-z(81)];
    sensorreading = [0;data(:,i,i)-z(i)];
    plot(appliedf,sensorreading,'.')
    
    n = 0;
    af(1) = 0;
    sr(1) = 0;
    
    for j = 1:length(appliedf)
        if (appliedf(j) > -1)
            n = n+1;
            af(n) = appliedf(j);
            sr(n) = sensorreading(j);
        end
    end
    
    p(i,:) = polyfit(af,sr,1)
    
    hold on
    x= linspace(min(appliedf)-0.25,max(appliedf)+0.25, 4); % Adapt n for resolution of graph
    y= p(i,2)+p(i,1)*x;
    plot(x,y)
    
end

% will somehow need to determine if there are any points to be left off, do
% so if necessary, and then find regression lines with remaining points

% might be easier to see if also included data from the trial with higher
% forces