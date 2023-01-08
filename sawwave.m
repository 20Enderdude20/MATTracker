%%function [k] = sawwave(n,t)
%%k = 0;
%%for count = 0:n
%%k = k + 0.570*sin((1+count)*t)/(1+count);
%%end
%%end
function [k] = sawwave(t, fourier)
tr = mod(t(1,1),2*pi);
k = 0;
if fourier < inf
    for count = 0:fourier
        k = k + 0.570*sin((1+count)*tr)/(1+count);
    end
    return
end
k = -1 + tr/(pi);
end