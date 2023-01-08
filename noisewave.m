function [k] = noisewave(t, noisetable)
    k = noisetable( mod(ceil(t*length(noisetable)/(2*pi)), length(noisetable)) + 1);
end