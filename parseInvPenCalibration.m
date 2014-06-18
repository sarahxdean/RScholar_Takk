odata = calib;
len = size(odata,1);
offset = zeros(len/2,40);
um = zeros(len/2,40);

co = 0;
cu = 0;
for i=1:len
    if odata(i,81) == 150
        co = co+1;
        offset(co,:) = odata(i,1:40);
    else
        cu = cu+1;
        um(cu,:) = odata(i,1:40);
    end
        
end

offset = mean(offset);
wm = mean(um);

gain = 1 ./ (wm - offset);