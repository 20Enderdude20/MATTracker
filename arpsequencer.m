function [transpose] = arpsequencer(channel, track, tickcount, row, ins)

selectedinstrument = cast(track(row, channel*3 - 2), "double");

arplength = ins{1, selectedinstrument}(1, 4);

arploop = ins{1, selectedinstrument}(1, 6);

arplooplength = arplength - arploop + 1;
if tickcount <= arplength
    macrocount = tickcount;
elseif tickcount > arplength
    macrocount = arploop + mod(tickcount, arplooplength);
end
transpose = 2^(ins{1, selectedinstrument}(macrocount, 2)/12);
end