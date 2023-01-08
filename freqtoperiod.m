function [p] = freqtoperiod(f,r)
if r == 0
    p = 0;
else p = (f/r)*2*pi;
end