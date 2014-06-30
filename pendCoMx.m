function [xc] = pendCoMx(a)


    r = 106.214;
    theta = (512-(a+3)) .* 300 ./ 1024 .* pi ./ 180;
    
    xc = r * sin(theta);
    
end