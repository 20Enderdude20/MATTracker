function [vibratodepth_out, vibratofreq_out, vibratophase_out, portaenable_out, portarate_out] = commandsequencer (channel, track, row, vibratodepth_in, vibratofreq_in, vibratophase_in, portaenable_in, portarate_in)
    commandcheck = track(row, channel*4);
    vibratodepth_out = vibratodepth_in;
    vibratofreq_out = vibratofreq_in;
    portaenable_out = portaenable_in;
    portarate_out = portarate_in;
    vibratophase_out = vibratophase_in;
        if ismissing(commandcheck) == 1
            return;
        end
            currentcommandpacket = cast(track(row, channel*4), "char");
            commandnumber = currentcommandpacket(1);
            commandparameter1 = hex2dec(currentcommandpacket(2));
            commandparameter2 = hex2dec(currentcommandpacket(3));
            commandparameter3 = hex2dec(currentcommandpacket(2:end));
            if commandnumber == "3"
                if commandparameter3 == 0
                    portaenable_out = 0;
                else
                    portaenable_out = 1;
                    portarate_out = commandparameter3;
                    return;
                end
            end
            if commandnumber == "4"
                vibratofreq_out = commandparameter1;
                vibratodepth_out = commandparameter2;
                if vibratodepth_out == 0 || vibratofreq_out == 0
                    vibratophase_out = 0;
                end
                return;
            end  
end