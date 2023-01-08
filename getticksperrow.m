function [ticks] = getticksperrow(track, row)
ticks = cast(track(row, 13), "double");
end