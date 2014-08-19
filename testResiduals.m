function [r] = testResiduals(data,baseline,weight,actual,pos,normalize,CoM)

if normalize
    product = productToRegress(data,baseline,pos,1) * weight;
    
elseif nargin > 6
    product = productToRegress(data,baseline,pos,0,CoM) * weight;
else
    product = productToRegress(data,baseline,pos,0) * weight;
end

actual;

r = product - actual;

end