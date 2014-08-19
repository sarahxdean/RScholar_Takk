%x = [4.76 2.38 4.76 2.38 4.76 10.76 8.38 10.76 8.38 10.76 16.76 14.38 16.76 14.38 16.76 22.76 20.38 22.76 20.38 22.76 28.76 26.38 28.76 26.38 28.76 34.76 32.38 34.76 32.38 34.76 40.76 38.38 40.76 38.38 40.76 46.76 44.38 46.76 44.38 46.76] - 24.808;
%y = [27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3] - 15;
function [weight,allr,allrt,allrl,allrh,allrt2,allrl2,allrh2] = findWeightsGENnormalizenonneg(data_standard,data_light,data_heavy,array,ds_2,dl_2,dh_2,both)

if array 
    x = arrayXPos;
    n = 40;
    %confirm right length data?
else
    x = stripXPos;
    n = 25;

end

allweight = zeros(n,1);
allr = 0;
allrt = 0;
allrl = 0;
allrh = 0;

allrt2 = 0;
allrl2 = 0;
allrh2 = 0;
    
for i=1:20    
    
    if nargin > 4
        if both
            [tr_1 ts] = split8020(data_standard);
            [tr_2 ts_2] = split8020(ds_2);
            tr = vertcat(tr_1,tr_2);
        else
            [tr ts] = split8020(data_standard);     
        end
    else
        [tr ts] = split8020(data_standard); %use 80% to do regression
    end
    
    %x_matrix = ones(size(tr(:,1:n,1)))*diag(x);
    
    product = productToRegress(tr(:,1:n,1),tr(:,1:n,2),1,tr(:,n+1,1));    
   
    weight = homogRegress(product);
    %see residuals
    %see test residuals individually for: remaining 20%, no weight, high
    %weight
    
    r = testResiduals(tr(:,1:n,1),tr(:,1:n,2),weight,zeros(length(tr(:,1,1)),1),1,tr(:,n+1,1));
    rt(:,1) = testResiduals(ts(:,1:n,1),ts(:,1:n,2),weight,zeros(length(ts(:,1,1)),1),1,ts(:,n+1,1));
    rl(:,1) = testResiduals(data_light(:,1:n,1),data_light(:,1:n,2),weight,zeros(length(data_light(:,1,1)),1),1,data_light(:,n+1,1));
    rh(:,1) = testResiduals(data_heavy(:,1:n,1),data_heavy(:,1:n,2),weight,zeros(length(data_heavy(:,1,1)),1),1,data_heavy(:,n+1,1));
    
    if nargin > 4
        if both
            r_t2 = testResiduals(ts_2(:,1:n,1),ts_2(:,1:n,2),weight,zeros(length(ts_2(:,1,1)),1),1,ts_2(:,n+1,1));
        else
            r_t2 = testResiduals(ds_2(:,1:n,1),ds_2(:,1:n,2),weight,zeros(length(ds_2(:,1,1)),1),1,ds_2(:,n+1,1));
        end
        r_l2 = testResiduals(dl_2(:,1:n,1),dl_2(:,1:n,2),weight,zeros(length(dl_2(:,1,1)),1),1,dl_2(:,n+1,1));
        r_h2 = testResiduals(dh_2(:,1:n,1),dh_2(:,1:n,2),weight,zeros(length(dh_2(:,1,1)),1),1,dh_2(:,n+1,1));
    end

    allweight = horzcat(allweight,weight);
    allr = vertcat(allr,r);
    allrt = vertcat(allrt,rt);
    allrl = vertcat(allrl,rl);
    allrh = vertcat(allrh,rh);

    if nargin > 4
    allrt2 = vertcat(allrt2,r_t2);
    allrl2 = vertcat(allrl2,r_l2);
    allrh2 = vertcat(allrh2,r_h2);
    end
    
end 
    res = sqrt(mean(allr(2:end).^2))
    standard = sqrt(mean(allrt(2:end).^2))
    light = sqrt(mean(allrl(2:end).^2))
    heavy = sqrt(mean(allrh(2:end).^2))


    if nargin > 4
    standard2 = sqrt(mean(allrt2(2:end).^2))
    light2 = sqrt(mean(allrl2(2:end).^2))
    heavy2 = sqrt(mean(allrh2(2:end).^2))
    end
end
%eigenvalue homogRegress (check with Dr. Lee's)
    %use 80% of a,b,c,f to do regression
    %see residuals
    %see test residuals individually for: remaining 20%, no weight, high
    %weight
    
    %use 80% of everything to do regression
    %see residuals
    %see test residuals individually for: remaining 20%, no weight, high
    %weight
    
%only positive constraint?!?!?!?