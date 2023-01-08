%%function [k] = triwave(n,t)
%%k1 = 0;
%%for count = 1:2:(2*n)+1
%%k1 = k1 + 0.8*(-1)^((count-1)/2)*(sin(count*t))/(count^2);
%%end
%%end
function [k] = triwave(t, fourier, ring)
tr = mod(t, 2*pi);
k1 = 0;
if fourier < inf
    for count = 1:2:(2*fourier)+1
        k1 = k1 + (-1)^((count-1)/2)*(sin(count*tr))/(count^2);
    end
    k = k1*ring;
    return
end
if tr < pi
    k1 = -1 + tr/(0.5*pi);
elseif tr > pi
    k1 = 1 - (tr-pi)/(0.5*pi);
end
k = k1*ring;
end