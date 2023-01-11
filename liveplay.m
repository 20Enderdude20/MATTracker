function liveplay (startrow, endrow, ins, track)
xtickcount=0;
ytickcount=0;
ztickcount=0;
xperiod = 0;
yperiod = 0;
zperiod = 0;
xsync = 0;
ysync = 0;
zsync = 0;
xnoterow = 1;
ynoterow = 1;
znoterow = 1;
xportae = 0;
yportae = 0;
zportae = 0;
xporta = 0;
yporta = 0;
zporta = 0;
xportadelta = 0;
yportadelta = 0;
zportadelta = 0;
xvibdepth = 0;
xvibfreq= 0;
xvibphase = 0;
yvibdepth = 0;
yvibfreq= 0;
yvibphase = 0;
zvibdepth = 0;
zvibfreq= 0;
zvibphase = 0;
xwidthdelay = 0;
ywidthdelay = 0;
zwidthdelay = 0;
xfourier = inf;
yfourier = inf;
zfourier = inf;
portaconstant = 0.25;
portapower = 0.01;
xring = 1;
 xringe = 0;
yring = 1;
 yringe = 0;
zring = 1;
 zringe = 0;
 tickcount = 0;
 firstrow = 1;
 ticksperrow = 1;
 buffer = 8;
 for currentrowplay = startrow:buffer:endrow
    tic
    [xtickcount, ytickcount, ztickcount, ticksperrow, xperiod, yperiod, zperiod, xsync, ysync, zsync, xnoterow, ynoterow, znoterow, xportae, yportae, zportae, xporta, yporta, zporta, xportadelta, yportadelta, zportadelta, xvibdepth, xvibfreq, xvibphase, yvibdepth, yvibfreq, yvibphase, zvibdepth, zvibfreq, zvibphase, xwidthdelay, ywidthdelay, zwidthdelay, xfourier, yfourier, zfourier, portaconstant, portapower, xring, xringe, yring, yringe, zring, zringe, tickcount] = playc(currentrowplay, currentrowplay + buffer - 1, ins, track, xtickcount, ytickcount, ztickcount, ticksperrow, xperiod, yperiod, zperiod, xsync, ysync, zsync, xnoterow, ynoterow, znoterow, xportae, yportae, zportae, xporta, yporta, zporta, xportadelta, yportadelta, zportadelta, xvibdepth, xvibfreq, xvibphase, yvibdepth, yvibfreq, yvibphase, zvibdepth, zvibfreq, zvibphase, xwidthdelay, ywidthdelay, zwidthdelay, xfourier, yfourier, zfourier, portaconstant, portapower, xring, xringe, yring, yringe, zring, zringe, tickcount);
    T = toc;
    pause (ticksperrow /(50/buffer) - T);
end
clearvars -except track ins
end