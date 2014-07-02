function [xc] = pendCoMx(a)


    r = 102.1;
    theta = (507-a) .* 300 ./ 1024 .* pi ./ 180;
    
    xc = r * sin(theta);
    
end