function [xc] = pendCoM(a,r,ac)

    theta = (ac - a) .* 300 ./ 1024 .* pi ./ 180;
    
    xc = r * sin(theta);
    
end