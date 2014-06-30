function [xc] = pendCoM(a)
    r = 106.214;
    theta = (512-(xc+3))*300/1024;
    xc = r * sin(theta);
    
end