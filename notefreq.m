function [f] = notefreq(n, detune)
note_lut = ["OFF", "0", "C", "C#", "D", "D#" "E", "F", "F#", "G", "G#", "A", "A#", "B";
            "0", "0", "261.63", "277.18", "293.66", "311.13" "329.63", "349.23", "369.99", "392.00", "415.30", "440.00", "466.16", "493.88"];
if n =="OFF"
    f = 0;
else
note_and_octave = split(n);
note = note_and_octave(1);
o = note_and_octave(2);
c = cast(o,"double");

[~,foundfreq] = find(note_lut==note);

basenote = cast(note_lut(2, foundfreq), "double");
f = basenote(1,1)*2^(c-4 + (detune/1200));
end
end
