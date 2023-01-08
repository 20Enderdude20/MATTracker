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
function [rt] = squarewave(t, fourier)
tr = mod(t(1,1),2*pi);
if fourier >= 20
    if t(1,1) == 0
        rt(1,1)=0;
    else
        if tr < pi
            rt = 1;
        elseif tr >= pi
                rt = -1;
        end
    end
else
    if fourier <= 0
        rt = sin(t);
    else
    rt = 0;  
    for count = 0:fourier
    rt = rt + sin((1+(2*count))*t)/(1+(2*count));
    end
    end
end