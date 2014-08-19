%x = [4.76 2.38 4.76 2.38 4.76 10.76 8.38 10.76 8.38 10.76 16.76 14.38 16.76 14.38 16.76 22.76 20.38 22.76 20.38 22.76 28.76 26.38 28.76 26.38 28.76 34.76 32.38 34.76 32.38 34.76 40.76 38.38 40.76 38.38 40.76 46.76 44.38 46.76 44.38 46.76] - 24.808;
%y = [27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3 27 21 15 9 3] - 15;

%type must be one of the following: original, originalnonneg, norm, 
%normnonneg, eigen
function [avgweight,summary,example,allr,allrt,allrl,allrh,allrt2,allrl2,allrh2] = findWeightsGEN(type,ds_1,dl_1,dh_1,pos1,ds_2,dl_2,dh_2,pos2,both)

n = length(pos1)

%original method
allweight = zeros(n,1);
allr = 0;
allrt = 0;
allrl = 0;
allrh = 0;

allrt2 = 0;
allrl2 = 0;
allrh2 = 0;


    
for i=1:20    
    if nargin > 5
        if both
            [tr_1 ts] = split8020(ds_1);
            [tr_2 ts_2] = split8020(ds_2);
            tr = vertcat(tr_1,tr_2);
        else
            [tr ts] = split8020(ds_1);     
        end
    else
        [tr ts] = split8020(ds_1); %use 80% to do regression
    end

    if strcmp(type,'original')
        product = productToRegress(tr(:,1:n,1),tr(:,1:n,2),pos1,0);
        [weight,bint,r,rint] = regress(tr(:,n+1,1),product);
        norm = 0;

    elseif strcmp(type,'originalnonneg')
        product = productToRegress(tr(:,1:n,1),tr(:,1:n,2),pos1,0);
        [weight,resnorm,r,exitflag] = lsqnonneg(product,tr(:,n+1,1));
        norm = 0;

    elseif strcmp(type,'norm')
        product = productToRegress(tr(:,1:n,1),tr(:,1:n,2),pos1,1);
        [weight,bint,r,rint] = regress(tr(:,n+1,1),product);
        norm = 1;

    elseif strcmp(type,'normnonneg')
        product = productToRegress(tr(:,1:n,1),tr(:,1:n,2),pos1,1) ;      
        [weight,resnorm,r,exitflag] = lsqnonneg(product,tr(:,n+1,1));
        norm = 1;

    elseif strcmp(type,'eigen')
        product = productToRegress(tr(:,1:n,1),tr(:,1:n,2),pos1,0,tr(:,n+1,1));    
        weight = homogRegress(product);
        r = testResiduals(tr(:,1:n,1),tr(:,1:n,2),weight,zeros(length(tr(:,1,1)),1),pos1,1,tr(:,n+1,1));
        norm = 0;

    else
        disp('type must be one of the following: original, originalnonneg, norm, normnonneg, eigen')
        return
    end

    %exitflag
    allweight = horzcat(allweight,weight);
    %see residuals
    %see test residuals individually for: remaining 20%, no weight, high
    %weight

    if strcmp(type,'eigen')
        rt = testResiduals(ts(:,1:n,1),ts(:,1:n,2),weight,ts(:,n+1,1),pos1,norm,ts(:,n+1,1));
        rl = testResiduals(dl_1(:,1:n,1),dl_1(:,1:n,2),weight,dl_1(:,n+1,1),pos1,norm,dl_1(:,n+1,1));
        rh = testResiduals(dh_1(:,1:n,1),dh_1(:,1:n,2),weight,dh_1(:,n+1,1),pos1,norm,dh_1(:,n+1,1));
        if nargin > 5
            if both
                r_t2 = testResiduals(ts_2(:,1:n,1),ts_2(:,1:n,2),weight,ts_2(:,n+1,1),pos1,norm,ts_2(:,n+1,1));
            else
                r_t2 = testResiduals(ds_2(:,1:n,1),ds_2(:,1:n,2),weight,ds_2(:,n+1,1),pos1,norm,ds_2(:,n+1,1));
            end
            r_l2 = testResiduals(dl_2(:,1:n,1),dl_2(:,1:n,2),weight,dl_2(:,n+1,1),pos1,norm,dl_2(:,n+1,1));
            r_h2 = testResiduals(dh_2(:,1:n,1),dh_2(:,1:n,2),weight,dh_2(:,n+1,1),pos1,norm,dh_2(:,n+1,1));
        end
    else
        rt = testResiduals(ts(:,1:n,1),ts(:,1:n,2),weight,ts(:,n+1,1),pos1,norm);
        rl = testResiduals(dl_1(:,1:n,1),dl_1(:,1:n,2),weight,dl_1(:,n+1,1),pos1,norm);
        rh = testResiduals(dh_1(:,1:n,1),dh_1(:,1:n,2),weight,dh_1(:,n+1,1),pos1,norm);
        if nargin > 5
            if both
                r_t2 = testResiduals(ts_2(:,1:n,1),ts_2(:,1:n,2),weight,ts_2(:,n+1,1),pos1,norm);
            else
                r_t2 = testResiduals(ds_2(:,1:n,1),ds_2(:,1:n,2),weight,ds_2(:,n+1,1),pos1,norm);
            end
            r_l2 = testResiduals(dl_2(:,1:n,1),dl_2(:,1:n,2),weight,dl_2(:,n+1,1),pos1,norm);
            r_h2 = testResiduals(dh_2(:,1:n,1),dh_2(:,1:n,2),weight,dh_2(:,n+1,1),pos1,norm);
        end
    end


    
    allr = vertcat(allr,r);
    allrt = vertcat(allrt,rt);
    allrl = vertcat(allrl,rl);
    allrh = vertcat(allrh,rh);

    if nargin > 5
    allrt2 = vertcat(allrt2,r_t2);
    allrl2 = vertcat(allrl2,r_l2);
    allrh2 = vertcat(allrh2,r_h2);
    end
    
end

avgweight = mean(allweight,2);
%should example be from individual regression or from average? how much
%should i look at distributions?

exnum=85;

%lots of extra computation
if norm
    product = productToRegress(ds_1(:,1:n,1),ds_1(:,1:n,2),pos1,1) * avgweight;
    %product2 = productToRegress(ds_1(:,1:n,1),ds_1(:,1:n,2),pos2,1) * avgweight;
elseif strcmp(type,'eigen')
    product = productToRegress(ds_1(:,1:n,1),ds_1(:,1:n,2),pos1,0,ds_1(:,n+1,1)) * avgweight;
    %product2 = productToRegress(ds_1(:,1:n,1),ds_1(:,1:n,2),pos2,0,ds_1(:,n+1,1)) * avgweight;
else
    product = productToRegress(ds_1(:,1:n,1),ds_1(:,1:n,2),pos1,0) * avgweight;
    %product2 = productToRegress(ds_1(:,1:n,1),ds_1(:,1:n,2),pos2,0,ds_1(:,n+1,1)) * avgweight;
end

example = [ds_1(exnum,1:end-1,2)-ds_1(exnum,1:end-1,1) ds_1(exnum,end,1) product(exnum)]% product2(exnum)]
    
    res = sqrt(mean(allr(2:end).^2));
    standard = sqrt(mean(allrt(2:end).^2));
    light = sqrt(mean(allrl(2:end).^2));
    heavy = sqrt(mean(allrh(2:end).^2));

    summary = [res standard light heavy];

    if nargin > 5
    standard2 = sqrt(mean(allrt2(2:end).^2));
    light2 = sqrt(mean(allrl2(2:end).^2));
    heavy2 = sqrt(mean(allrh2(2:end).^2));

    summary = [summary standard2 light2 heavy2];
    end
    
end
    
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