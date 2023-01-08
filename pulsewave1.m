%%function [t] = squarewave(n,f)
%%t = 0;
%%for count = 0:n
%%t = t + sin((1+(2*count))*f)/(1+(2*count));
%%end
%%end
%%function [k] = squarewave(n,f)
%%t = 0;
%%for count = 0:n
%%t = t + sin((1+(2*count))*f)/(1+(2*count));
%%k = 2*round((t*0.5)+0.5) - 1;
%%end
%%end
function [rt] = pulsewave(t,d,fourier)
tr = mod(t(1,1),2*pi);
if fourier <= 0
    rt = sin(t);
    return
end
if fourier ~= inf
    rt1 = 0;
    rt2 = 0;
    topf = ceil(fourier);
    bottomf = floor(fourier);
    deltaf = fourier - bottomf;
    for count = 1:topf
        rt1 = rt1 + sin(pi*count*d)*cos(count*t-count*pi*d)/count;
    end
    for count = 1:bottomf
        rt2 = rt2 + sin(pi*count*d)*cos(count*t-count*pi*d)/count;
    end
    rt3 = rt1*(4/pi) + 2*d - 1;
    rt4 = rt2*(4/pi) + 2*d - 1;
    rt = rt3*(deltaf) + rt4*(1 - deltaf);
    return
end
if t(1,1) == 0
    rt(1,1)=0;
else
    if tr < 2*pi*d
        rt = 0.75;
    elseif tr >= 2*pi*d
        rt = -0.75;
    end
end
end