function [n] = getoutsamplelength(samplerate, hz, track, songlength)
n = 1;

    for row = 1:songlength
        tpr = getticksperrow(track, row);
    
        if isnan (tpr) == false
            ticksperrow = getticksperrow(track, row);
        end
        n = n + (samplerate/hz)*ticksperrow;
    end
end
