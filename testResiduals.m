function [r] = testResiduals(data,baseline,weight,actual,normalize,CoM)

if nargin == 5
    product = productToRegress(data,baseline,1) * weight;
    
elseif nargin == 6
    product = productToRegress(data,baseline,0,CoM) * weight;
else
    product = productToRegress(data,baseline) * weight;
end



r = product - actual;

end