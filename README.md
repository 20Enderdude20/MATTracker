# MATTracker
A synthesizer/tracker for MATLAB based on Commodore 64 SID chip capabilities


# 1. Introduction
This was a hobby project I started when I was getting bored of MATLAB during one semester lol
# 2. How to use it
So, for each song, there are two basic pieces of data (at least for now): The track's data itself, which is a 2d string vector named "track", and the instrument data, which is in the form factor of a struct called "ins".
TODO: add screenshots to illustrate the structures of both arrays
# 3.
This synthesizer/tracker program, as said in the brief summary, was inspired off of the capabilities of the SID chip.
The synthesizer is currently capable of:
Pulse width modulation (PWM)
Triangle wave
Sawtooth wave
Fourier summation of the previously mentioned waves (as a stand-in for real low-pass filtering)
Noise generation
& Echo generation with 4-bit quantization and downsampling (along with distorting the output of channels), akin to some C64 songs that abuse the SID's volume register bug.

The tracker portion of MATTracker is capable of sequencing all of these parameters in instruments.
The track itself is currently only capable of sequencing:
Note pitch
Volume
Legato
Vibrato
& Glissando (pitch bending to another note).

More will quite possibly be added to what can be sequenced in the track itself instead of relying on instruments.
