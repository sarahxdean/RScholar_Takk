x = [4.76 2.38 4.76 2.38 4.76 10.76 8.38 10.76 8.38 10.76 16.76 14.38 16.76 14.38 16.76 22.76 20.38 22.76 20.38 22.76 28.76 26.38 28.76 26.38 28.76 34.76 32.38 34.76 32.38 34.76 40.76 38.38 40.76 38.38 40.76 46.76 44.38 46.76 44.38 46.76] - 24.808;
y = [27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3] - 15;

%original method
    %use 80% of a,b,c,f to do regression
allweight = zeros(40,1);
allr = 0;
allrt = 0;
allrl = 0;
allrh = 0;
    
for i=1:20    
    [tr_a ts_a] = split8020(data_a);
    [tr_b ts_b] = split8020(data_b);
    [tr_c ts_c] = split8020(data_c);
    [tr_f ts_f] = split8020(data_f);
    
    x_matrix = ones(size(tr_a(:,1:40)))*diag(x);
    
    product_a = productToRegress(tr_a(:,1:40),baseline_a(1:40));
    product_b = productToRegress(tr_b(:,1:40),baseline_b(1:40));
    product_c = productToRegress(tr_c(:,1:40),baseline_c(1:40));
    product_f = productToRegress(tr_f(:,1:40),baseline_f(1:40));
    
    tr = vertcat(tr_a,tr_b,tr_c,tr_f);
    product = vertcat(product_a,product_b,product_c,product_f);
        
    [weight,bint,r,rint] = regress(tr(:,41),product);
    allweight = horzcat(allweight,weight);
    %see residuals
    %see test residuals individually for: remaining 20%, no weight, high
    %weight
    r_a = testResiduals(ts_a(:,1:40),baseline_a(1:40),weight,ts_a(:,41));
    r_b = testResiduals(ts_b(:,1:40),baseline_b(1:40),weight,ts_b(:,41));
    r_c = testResiduals(ts_c(:,1:40),baseline_c(1:40),weight,ts_c(:,41));
    r_f = testResiduals(ts_f(:,1:40),baseline_f(1:40),weight,ts_f(:,41));
    r_d = testResiduals(data_d(:,1:40),baseline_d(1:40),weight,data_d(:,41));
    r_e = testResiduals(data_e(:,1:40),baseline_e(1:40),weight,data_e(:,41));
    
    allr = vertcat(allr,r);
    allrt = vertcat(allrt,r_a,r_b,r_c,r_f);
    allrl = vertcat(allrl,r_d);
    allrh = vertcat(allrh,r_e);
    
end
    
    res = mean(abs(allr(2:end)))
    standard = mean(abs(allrt(2:end)))
    light = mean(abs(allrl(2:end)))
    heavy = mean(abs(allrh(2:end)))
    
    %use 80% of everything to do regression
    %see residuals
    %see test residuals individually for: remaining 20%, no weight, high
    %weight
    
%normalize forces - then original method
    %use 80% of a,b,c,f to do regression
    %see residuals
    %see test residuals individually for: remaining 20%, no weight, high
    %weight
    
    %use 80% of everything to do regression
    %see residuals
    %see test residuals individually for: remaining 20%, no weight, high
    %weight
    
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