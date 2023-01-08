function [transpose, volume, wave, width, sync, fourier, ringe] = inssequencer(channel, track, tickcount, row, ins1, realrow, trackvolrow)

channelnote = track(realrow, channel*4 - 2);

%In-track volume
trackvol = getcurrentvol(channel, track, trackvolrow);

selectedinstrument = cast(track(row, channel*4 - 3), "double");

%Volume macro
vollength = length(ins1(selectedinstrument).volume);

vollooplength = vollength - ins1(selectedinstrument).volloop + 1;
if tickcount <= vollength
    macrocount = tickcount;
elseif tickcount > vollength
    macrocount = ins1(selectedinstrument).volloop + mod(tickcount - 1, vollooplength);
end
volume = round((trackvol/15)*(ins1(selectedinstrument).volume(macrocount)))/15;
if channelnote == "0" || channelnote == "OFF"
    volume = 0;
end
%Arpeggio macro
arplength = length(ins1(selectedinstrument).arpeggio);

arplooplength = arplength - ins1(selectedinstrument).arploop + 1;
if tickcount <= arplength
    macrocount = tickcount;
elseif tickcount > arplength
    macrocount = ins1(selectedinstrument).arploop + mod(tickcount, arplooplength);
end
transpose = 2^(ins1(selectedinstrument).arpeggio(macrocount)/12);
%Waveform macro
wavemaclength = length(ins1(selectedinstrument).waveform);

wavemaclooplength = wavemaclength - ins1(selectedinstrument).waveloop + 1;
if tickcount <= wavemaclength
    macrocount = tickcount;
elseif tickcount > wavemaclength
    macrocount = ins1(selectedinstrument).waveloop + mod(tickcount - 1, wavemaclooplength);
end
wave = ins1(selectedinstrument).waveform(macrocount);
%Pulse width macro
widthmaclength = length(ins1(selectedinstrument).pulsewidth);

widthmaclooplength = widthmaclength - ins1(selectedinstrument).pulseloop + 1;
if tickcount <= widthmaclength
    macrocount = tickcount;
elseif tickcount > widthmaclength
    macrocount = ins1(selectedinstrument).pulseloop + mod(tickcount - 1, widthmaclooplength);
end
width = ins1(selectedinstrument).pulsewidth(macrocount)/255;

%Sync macro
syncmaclength = length(ins1(selectedinstrument).sync);

syncmaclooplength = syncmaclength - ins1(selectedinstrument).syncloop + 1;
if tickcount <= syncmaclength
    macrocount = tickcount;
elseif tickcount > syncmaclength
    macrocount =  ins1(selectedinstrument).syncloop + mod(tickcount - 1, syncmaclooplength);
end
sync =  ins1(selectedinstrument).sync(macrocount);
%Fourier approximation macro (stand-in for a real filter lol)
fouriermaclength = length(ins1(selectedinstrument).filter);

fouriermaclooplength = fouriermaclength - ins1(selectedinstrument).filterloop + 1;
if tickcount <= fouriermaclength
    macrocount = tickcount;
elseif tickcount > fouriermaclength
    macrocount = ins1(selectedinstrument).filterloop + mod(tickcount - 1, fouriermaclooplength);
end
fourier = ins1(selectedinstrument).filter(macrocount);

%Ring modulation macro
ringmaclength = length(ins1(selectedinstrument).ring);

ringmaclooplength = ringmaclength - ins1(selectedinstrument).ringloop + 1;
if tickcount <= ringmaclength
    macrocount = tickcount;
elseif tickcount > ringmaclength
    macrocount = ins1(selectedinstrument).ringloop + mod(tickcount - 1, ringmaclooplength);
end
ringe = ins1(selectedinstrument).ring(macrocount);
end