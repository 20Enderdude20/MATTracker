function [vol] = getcurrentvol(channel, track, row)
vol = cast(track(row, channel*4 - 1), "double");
end