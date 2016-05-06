module jack.port;
import jack.defs : jack_port_t, jack_nframes_t, jack_default_audio_sample_t;
import jack.c;

pragma(inline) @nogc:

jack_default_audio_sample_t[] getBuffer(jack_port_t *port, jack_nframes_t n)
{
	auto p = cast(jack_default_audio_sample_t*) jack_port_get_buffer(port,n);
	return p[0..n];
}