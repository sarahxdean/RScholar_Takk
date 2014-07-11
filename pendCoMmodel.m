function [r,ac] = pendCoMmodel(min,max,l)

    ac = mean([min max]);
    theta = (ac-min) * 300 / 1024 * pi / 180;
    
    r = l / sin(theta);
    
end