function [outperiod] = notesequencer(channel, track, detune, k)
trackindex = height(track);
if k > trackindex
    outperiod = 0;
else 
    channel_note = track(k, (4*channel) - 2);
    outperiod = notefreq(channel_note, detune);
end
end