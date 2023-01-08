function [note] = getcurrentnote(channel, track, k)
note = track(k, 4*channel - 2);
end