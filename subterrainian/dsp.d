module dsp;

import types : nframes_t;
import std.range : take;
import std.algorithm : copy;
alias copyTo = copy;
import mixer,loops;


void process (nframes_t n)
{
	loops.process(n);
	mixer.inputs[0].channels[0].buffer[0..n].copyTo(mixer.main.channels[1].buffer[0..n]);
}