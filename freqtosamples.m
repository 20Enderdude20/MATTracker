function [p] = freqtosamples(f,r)
if r == 0
    p = 0;
else p = (1/f(1,1))*r;
end