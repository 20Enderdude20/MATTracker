function [ins] = getcurrentins(channel, track, row)
ins = cast(track(row, channel*4 - 3), "double");
end