function [rt] = noisewavefourier(t,noisetable,fourier)
tr = mod(t(1,1),2*pi);
if fourier <= 0
    rt = sin(t);
    return
end
if fourier < 30
 rt = sin(2*pi*sin(2*pi*sin(2*pi*t*fourier/30)));
    return
end
rt = noisetable( mod(ceil(t*length(noisetable)/(2*pi)), length(noisetable)) + 1);
end