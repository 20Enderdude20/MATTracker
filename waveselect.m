function [k, period] = waveselect(noise_freq_divide, t, noisetable, width, wavetype, fourier, ring, vol)
    period = t;
    if wavetype == 1
        k = vol*pulsewave(t, width, fourier);
        period = mod(t, 2*pi);
        return
    elseif wavetype == 2
        k = vol*triwave (t, fourier, ring);
        period = mod(t, 2*pi);
        return
    elseif wavetype == 3
        period = mod(t, 2*pi);
        k = vol*sawwave (t, fourier);
        return
    elseif wavetype == 4
            k = vol*noisewave(t/noise_freq_divide, noisetable);
            period = mod(t, 2*pi*noise_freq_divide);
        return
    elseif wavetype == 5
        k = vol*noisewavefourier(t/noise_freq_divide, noisetable, fourier);
        return
    else
        period = mod(period, 2*pi);
        k = ring*vol*squarewave(t, inf);
        return
    end
end
