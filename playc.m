function [xtickcount, ytickcount, ztickcount, ticksperrow, xperiod, yperiod, zperiod, xsync, ysync, zsync, xnoterow, ynoterow, znoterow, xportae, yportae, zportae, xporta, yporta, zporta, xportadelta, yportadelta, zportadelta, xvibdepth, xvibfreq, xvibphase, yvibdepth, yvibfreq, yvibphase, zvibdepth, zvibfreq, zvibphase, xwidthdelay, ywidthdelay, zwidthdelay, xfourier, yfourier, zfourier, portaconstant, portapower, xring, xringe, yring, yringe, zring, zringe, tickcount] = playc(startrow, endrow, ins, track, xtickcount, ytickcount, ztickcount, ticksperrow, xperiod, yperiod, zperiod, xsync, ysync, zsync, xnoterow, ynoterow, znoterow, xportae, yportae, zportae, xporta, yporta, zporta, xportadelta, yportadelta, zportadelta, xvibdepth, xvibfreq, xvibphase, yvibdepth, yvibfreq, yvibphase, zvibdepth, zvibfreq, zvibphase, xwidthdelay, ywidthdelay, zwidthdelay, xfourier, yfourier, zfourier, portaconstant, portapower, xring, xringe, yring, yringe, zring, zringe, tickcount)
echodelay = 0.34607709750566893424036281179138; % In seconds.
%startrow = 1099;
hz = 50;
detune = 25;
outsamplerate = 44100;
echoenable = true;
insamplerate = 5512.5;
downsample = round(outsamplerate/insamplerate);
% Initialization.
%freqrecordcount = 0;
noisefreqdivide = 10;
outsamplecount = getoutsamplelength(outsamplerate, hz, track, startrow, endrow);
%outsamplecount = outsamplerate/hz;
x = zeros(1, outsamplecount);
y = x;
z = x;
z2=x;
w = x;
w1 = x;
%soundc = audioplayer(w, outsamplerate);
pcmbitcrush = x;
downsampled = x;
countsample = 1;
%xtickcount = 0;
%ytickcount = 0;
%ztickcount = 0;
%xperiod = 0;
%yperiod = 0;
%zperiod = 0;
%xsync = 0;
%ysync = 0;
%zsync = 0;
%xnoterow = 1;
%ynoterow = 1;
%znoterow = 1;
%xportae = 0;
%yportae = 0;
%zportae = 0;
%xporta = 0;
%yporta = 0;
%zporta = 0;
%xportadelta = 0;
%yportadelta = 0;
%zportadelta = 0;
%xvibdepth = 0;
%xvibfreq= 0;
%xvibphase = 0;
%yvibdepth = 0;
%yvibfreq= 0;
%yvibphase = 0;
%zvibdepth = 0;
%zvibfreq= 0;
%zvibphase = 0;
%xwidthdelay = 0;
%ywidthdelay = 0;
%zwidthdelay = 0;
%xfourier = inf;
%yfourier = inf;
%zfourier = inf;
%portaconstant = 0.25;
%portapower = 0.01;
%xring = 1;
% xringe = 0;
%yring = 1;
% yringe = 0;
%zring = 1;
% zringe = 0;
% tickcount = 0;
 firstrow = 1;
for row = startrow:endrow
    tpr = getticksperrow(track, row);

    % Ticks per row and storing
    if isnan (tpr) == false
        ticksperrow = getticksperrow(track, row);
    end

    % Current note for each channel and storing, including the previous
    % note.
    xnoterowcheck = getcurrentnote(1, track, row);
    ynoterowcheck = getcurrentnote(2, track, row);
    znoterowcheck = getcurrentnote(3, track, row);
    if ismissing (xnoterowcheck) == false
        xnoterowbefore = xnoterow;
        xfreqprev = notesequencer(1, track, detune, xnoterowbefore);
        xnoterow = row;
        xportae = 0;
        xportadelta = 0;
    end
    if ismissing (ynoterowcheck) == false
        ynoterowbefore = ynoterow;
        yfreqprev = notesequencer(2, track, detune, ynoterowbefore);
        ynoterow = row;
        yportae = 0;
        yportadelta = 0;
    end
    if ismissing (znoterowcheck) == false
        znoterowbefore = znoterow;
        zfreqprev = notesequencer(3, track, detune, znoterowbefore);
        znoterow = row;
        zportae = 0;
        zportadelta = 0;
    end

    if firstrow == 1
        xnotebrow = startrow;
        ynotebrow = startrow;
        znotebrow = startrow;
        while ismissing (xnoterowcheck)
            xnotebrow = xnotebrow - 1;
            xnoterowcheck = getcurrentnote(1, track, xnotebrow);
        end
        xnoterowbefore = xnotebrow;
        xfreqprev = notesequencer(1, track, detune, xnoterowbefore);
        xnoterow = xnotebrow;
        while ismissing (ynoterowcheck)
            ynotebrow = ynotebrow - 1;
            ynoterowcheck = getcurrentnote(2, track, ynotebrow);
        end
        ynoterowbefore = ynotebrow;
        yfreqprev = notesequencer(2, track, detune, ynoterowbefore);
        ynoterow = ynotebrow;
        while ismissing (znoterowcheck)
            znotebrow = znotebrow - 1;
            znoterowcheck = getcurrentnote(3, track, znotebrow);
        end
        znoterowbefore = znotebrow;
        zfreqprev = notesequencer(3, track, detune, znoterowbefore);
        znoterow = znotebrow;
    end

    xfreqfinal = notesequencer(1, track, detune, xnoterow);
    yfreqfinal = notesequencer(2, track, detune, ynoterow);
    zfreqfinal = notesequencer(3, track, detune, znoterow);
    % Current instrument and storing, also resets macro timer of
    % instrument.
    xinsrowcheck = getcurrentins(1, track, row);
    yinsrowcheck = getcurrentins(2, track, row);
    zinsrowcheck = getcurrentins(3, track, row);
    if isnan (xinsrowcheck) == false
        %xperiod = 0; %For samples only
        xtickcount = 0;
        xinsrow = row;
    end
    if isnan (yinsrowcheck) == false
        %yperiod = 0; %For samples only
        ytickcount = 0;
        yinsrow = row;
    end
    if isnan (zinsrowcheck) == false
        %zperiod = 0; %For samples only
        ztickcount = 0;
        zinsrow = row;
    end
    % Current volume and storing.
    xvolrowcheck = getcurrentvol(1, track, row);
    yvolrowcheck = getcurrentvol(2, track, row);
    zvolrowcheck = getcurrentvol(3, track, row);

    if isnan (xvolrowcheck) == false
        xvolrow = row;
    end
    if isnan (yvolrowcheck) == false
        yvolrow = row;
    end
    if isnan (zvolrowcheck) == false
        zvolrow = row;
    end
    % Command sequencer.
    [xvibdepth, xvibfreq, xvibphase, xportae, xporta] = commandsequencer(1, track, row, xvibdepth, xvibfreq, xvibphase, xportae, xporta);
    [yvibdepth, yvibfreq, yvibphase, yportae, yporta] = commandsequencer(2, track, row, yvibdepth, yvibfreq, yvibphase, yportae, yporta);
    [zvibdepth, zvibfreq, zvibphase, zportae, zporta] = commandsequencer(3, track, row, zvibdepth, zvibfreq, zvibphase, zportae, zporta);
    if firstrow == 1
    xvolbrow = startrow;
    yvolbrow = startrow;
    zvolbrow = startrow;
    xinsbrow = startrow;
    yinsbrow = startrow;
    zinsbrow = startrow;
    ticksbrow = startrow;
    %xtickcount = 0;
    %ytickcount = 0;
    %ztickcount = 0;
    end
    % Initialization for playing from the middle of a song.
    if firstrow == 1
        % Find ticks per row
        while isnan (tpr)
            ticksbrow = ticksbrow - 1;
            tpr = getticksperrow(track, ticksbrow);
        end
            ticksperrow = tpr;
        % Find the instruments for each channel.
        while isnan (xinsrowcheck)
            xinsbrow = xinsbrow - 1;
            xinsrowcheck = getcurrentins(1, track, xinsbrow);
            xinsrow = xinsbrow;
        end
        while isnan (yinsrowcheck)
            yinsbrow = yinsbrow - 1;
            yinsrowcheck = getcurrentins(2, track, yinsbrow);
            yinsrow = yinsbrow;
        end
        while isnan (zinsrowcheck)
            zinsbrow = zinsbrow - 1;
            zinsrowcheck = getcurrentins(3, track, zinsbrow);
            zinsrow = zinsbrow;
        end
        % Find the volume for each channel.
        while isnan (xvolrowcheck)
            xvolbrow = xvolbrow - 1;
            xvolrowcheck = getcurrentvol(1, track, xvolbrow);
        end
        xvolrow = xvolbrow;
        while isnan (yvolrowcheck)
            yvolbrow = yvolbrow - 1;
            yvolrowcheck = getcurrentvol(2, track, yvolbrow);
        end
        yvolrow = yvolbrow;
        while isnan (zvolrowcheck)
            zvolbrow = zvolbrow - 1;
            zvolrowcheck = getcurrentvol(3, track, zvolbrow);
        end
        zvolrow = zvolbrow;
    end 
    firstrow = 0;
    for tick = 1:ticksperrow
        noisetable = (-1 + 2*round(128*rand(1, 2048))/128);
        %counter2(freqrecordcount) = freqrecordcount;
        %%% Portamento for X %%%
        if xfreqprev <= xfreqfinal
            xportadelta = xportadelta + portapower*(2^(xporta*portaconstant));
        elseif xfreqprev > xfreqfinal
            xportadelta = xportadelta - portapower*(2^(xporta*portaconstant));
        end
        if abs(xportadelta) >= abs(xfreqfinal - xfreqprev)
            xportae = 0;
            xfreq = xfreqfinal;
        end
        if xportae == 1 && xfreq ~= xfreqfinal
            xfreq = xfreqprev + xportadelta;
        else
            xfreq = xfreqfinal;
        end
        %%% Portamento for Y %%%
        if yfreqprev <= yfreqfinal
            yportadelta = yportadelta + portapower*(2^(yporta*portaconstant));
        elseif yfreqprev > yfreqfinal
            yportadelta = yportadelta - portapower*(2^(yporta*portaconstant));
        end
        if abs(yportadelta) >= abs(yfreqfinal - yfreqprev)
            yportae = 0;
            yfreq = yfreqfinal;
        end
        if yportae == 1 && yfreq ~= yfreqfinal
            yfreq = yfreqprev + yportadelta;
        else
            yfreq = yfreqfinal;
        end
        %%% Portamento for Z %%%
        if zfreqprev <= zfreqfinal
            zportadelta = zportadelta + portapower*(2^(zporta*portaconstant));
        elseif zfreqprev > zfreqfinal
            zportadelta = zportadelta - portapower*(2^(zporta*portaconstant));
        end
        if abs(zportadelta) >= abs(zfreqfinal - zfreqprev)
            zportae = 0;
            zfreq = zfreqfinal;
        end
        if zportae == 1 && zfreq ~= zfreqfinal
            zfreq = zfreqprev + zportadelta;
        else
            zfreq = zfreqfinal;
        end
        % Vibrato phases
        xvibphase = xvibphase + xvibfreq/8;
        yvibphase = yvibphase + yvibfreq/8;
        zvibphase = zvibphase + zvibfreq/8;

        xtickcount = xtickcount + 1;
        ytickcount = ytickcount + 1;
        ztickcount = ztickcount + 1;

        [xarp, xvol, xwave, xwidth, xsync, xfourier, xringe] = inssequencer(1, track, xtickcount, xinsrow, ins, xnoterow, xvolrow);
        [yarp, yvol, ywave, ywidth, ysync, yfourier, yringe] = inssequencer(2, track, ytickcount, yinsrow, ins, ynoterow, yvolrow);
        [zarp, zvol, zwave, zwidth, zsync, zfourier, zringe] = inssequencer(3, track, ztickcount, zinsrow, ins, znoterow, zvolrow);
        xfreqarp = xfreq*xarp*2^(xvibdepth*triwave(xvibphase, inf, 1)/256);
        yfreqarp = yfreq*yarp*2^(yvibdepth*triwave(yvibphase, inf, 1)/256);
        zfreqarp = zfreq*zarp*2^(zvibdepth*triwave(zvibphase, inf, 1)/256);

        xperiodarp = freqtoperiod(xfreqarp, outsamplerate);
        yperiodarp = freqtoperiod(yfreqarp, outsamplerate);
        zperiodarp = freqtoperiod(zfreqarp, outsamplerate);

        xfourier = xfourier/(xfreqarp/80);
        yfourier = yfourier/(yfreqarp/80);
        zfourier = zfourier/(zfreqarp/80);
        % xfreqrecord(freqrecordcount) = xfreq;
        % xtargetfreqrecord(freqrecordcount) = xfreqfinal;
        % ans = [xwave (log(xarp)/log(2))*12]
        
        for frame = 1:(outsamplerate/hz)
            countsample = countsample + 1;
            xperiod = xperiod + xperiodarp;
            yperiod = yperiod + yperiodarp;
            zperiod = zperiod + zperiodarp;
            % Sync modulation
            if zperiod > (2*pi) && xsync == 1
                xperiod = 0;
            end
            if xperiod > (2*pi) && ysync == 1
                yperiod = 0;
            end
            if yperiod > (2*pi) && zsync == 1
                zperiod = 0;
            end
            % Ring modulation
            if xwave == 2 && xringe == 1
                if mod(zperiod, 2*pi) < pi
                    xring = 1;
                else
                    xring = -1;
                end
            end

            if ywave == 2 && yringe == 1
                if mod(xperiod, 2*pi) < pi
                    yring = 1;
                else
                    yring = -1;
                end
            end

            if zwave == 2 && zringe == 1
                if mod(yperiod, 2*pi) < pi
                    zring = 1;
                else
                    zring = -1;
                end
            end
            % Only change the duty percent when the previous waveform
            % completes its cycle.
            if (xperiod >= (2*pi))
                xwidthdelay = xwidth;
            end
            if (yperiod >= (2*pi))
                ywidthdelay = ywidth;
            end
            if (zperiod >= (2*pi))
                zwidthdelay = zwidth;
            end

            [x(countsample), xperiod] = waveselect(noisefreqdivide, xperiod, noisetable, xwidthdelay, xwave, xfourier, xring, xvol);
            [y(countsample), yperiod] = waveselect(noisefreqdivide, yperiod, noisetable, ywidthdelay, ywave, yfourier, yring, yvol);
            [z(countsample), zperiod] = waveselect(noisefreqdivide, zperiod, noisetable, zwidthdelay, zwave, zfourier, zring, zvol);
            if echoenable == true
                z2(countsample)=zvol*waveselect1(noisefreqdivide, zperiod, noisetable, zwidthdelay, zwave, inf, zring, 1); % Used explicitly for the echo channel.
                downsampled(countsample + round(outsamplerate*echodelay)) = z2(ceil(countsample/downsample)*downsample - (downsample - 1));
                pcmbitcrush(countsample) = ceil(16*downsampled(countsample)/2)/16;
                w1(countsample)= x(countsample)*(1/5) + y(countsample)*(1/5) + z(countsample)*(1/5);
                w(countsample) = (1/5)*pcmbitcrush(countsample) + w1(countsample)*(1 + 0.2*pcmbitcrush(countsample));
            else
                w(countsample) = x(countsample)*(1/5) + y(countsample)*(1/5) + z(countsample)*(1/5);
            end
            
        end
        
    end
   
end
sound(w,outsamplerate);
%audiowrite('sound2.wav',w,outsamplerate)
%audiowrite('ch1.wav',0.7*x,outsamplerate)
%audiowrite('ch2.wav',0.7*y,outsamplerate)
%audiowrite('ch3.wav',0.7*z,outsamplerate)
%if echoenable == true
%audiowrite('echo.wav',0.7*ceil(16*downsampled(1:countsample)/4)/16,outsamplerate)
%end
%plot (counter2, xfreqrecord, counter2, xtargetfreqrecord)
%clearvars -except track ins xtickcount
end