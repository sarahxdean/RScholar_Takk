function [xc] = pendCoMy(a)


    r = 127.8;
    theta = (519-a) .* 300 ./ 1024 .* pi ./ 180;
    
    xc = r * sin(theta);
    
end