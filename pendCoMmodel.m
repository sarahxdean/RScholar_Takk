function [r,ac] = pendCoMmodel(min,max,l1,l2)

    if nargin > 3
        %l = (l1+l2)/2;
        l=l1;
        ac = (l1*min + l2*max) / (l1+l2);
    else
        l = l1;
        ac = mean([min max]);
    end

    
    theta = (ac-min) * 300 / 1024 * pi / 180;
    
    r = l / sin(theta);
    
end