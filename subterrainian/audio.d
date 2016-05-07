module audio;

import core.thread : Thread, ThreadID;
import core.time : msecs;

import std.experimental.allocator.mallocator : Mallocator;
import std.experimental.allocator : dispose;

import jack.defs : JACK_DEFAULT_AUDIO_TYPE, JackPortFlags;
import jack.client, jack.port;

import types,mixer,dsp;

enum char * app_name = ['s','u','b','t','e','r','r','a','i','n','i','a','n','\0'];

version (Posix) import core.sys.posix.pthread : pthread_self;

void open()
{
	client = jack.client.open(app_name,JackOptions.NullOption,status);
	assert (client != null, "AUDIO: can't connect to jack\n");

	foreach (ref input; mixer.inputs)
	{
		foreach (ref channel; input.channels)
		{
			channel.port = client.registerPort (channel.name, JACK_DEFAULT_AUDIO_TYPE, JackPortFlags.IsInput);
		}
	}
	foreach (ref output; mixer.aux)
	{
		foreach (ref channel; output.channels)
		{
			channel.port = client.registerPort (channel.name, JACK_DEFAULT_AUDIO_TYPE, JackPortFlags.IsOutput);
		}
	}
	foreach (ref channel; mixer.main.channels)
	{
		channel.port = client.registerPort (channel.name,JACK_DEFAULT_AUDIO_TYPE,JackPortFlags.IsOutput);
	}

	client.setProcessCallback(&process);
	client.setSamplerateCallback(&samplerate_callback);
	client.setTimebaseCallback!(Yes.Conditional)(&timebase_callback);
	client.onShutdownCallback(&on_shutdown);

	sample_rate = client.getSampleRate();
	time_scale = cast(float) client.getBufferSize()/sample_rate;
}

void close()
{
	client.deactivate;
	jack.client.close(client);
}

void start()
{
	auto b = client.activate;
	assert (b, "AUDIO: jack activation failed\n");

	void ** ports;
	ports = client.getPorts(null,null,JackPortFlags.IsInput|JackPortFlags.IsPhysical);
	assert (ports, "AUDIO: No Physical Inputs found\n");
	Mallocator.instance.dispose(ports);
	ports = client.getPorts(null,null,JackPortFlags.IsOutput|JackPortFlags.IsPhysical);
	assert (ports, "AUDIO: No Physical Outputs found\n");
	Mallocator.instance.dispose(ports);

	version (Posix)
	{
		while (thread_id == 0) Thread.sleep(msecs(10));
	}
	else assert (0, "POSIX currently supported only\n");
}

void finalise()
{
}

private __gshared
{
	JackClient client;
	JackStatus status;
	int sample_rate;
	float time_scale;
	ThreadID thread_id;
	float cpu_load;
}

extern (C) @nogc @trusted
{
	int process (nframes_t nframes, void *_)
	{
		version (Posix) if (thread_id == 0) 
			thread_id = pthread_self();
		cpu_load = client.CPULoad;

		foreach (ref input; mixer.inputs)
		{
			foreach (ref channel; input.channels)
			{
				channel.buffer = channel.port.getBuffer(nframes);
			}
		}
		foreach (ref output; mixer.aux)
		{
			foreach (ref channel; output.channels)
			{
				channel.buffer = channel.port.getBuffer(nframes);
			}
		}
		foreach (ref channel; mixer.main.channels)
		{
			channel.buffer = channel.port.getBuffer(nframes);
		}

		dsp.process(nframes);

		return 0;
	}

	void on_shutdown (void *_)
	{
	}

	int samplerate_callback (nframes_t nframes, void *_)
	{
		sample_rate = nframes;
		return 0;
	}

	void timebase_callback(JackTransportState state, nframes_t nframes, jack_position_t * pos, int new_pos, void * _ )
	{
//		timebase_master = true;
//		Pulse pulse = loops.currentPulse;
//								if (pulse)
//								{
//									if (repositioned)
//									{
//										repositioned = false;
//									}
//									else
//									{
//										client.locateTransport(pulse.pos);
//										repositioned = true;
//									}
//						
//									start_sync_frame = 0;
//								}
//						
//								enum ticks_per_beat = 1920;
//								int rel_frame = cast(int) pos.frame - sync_start_frame;
//								float rel_bar = cast(floa+	t)	+
//			+ rel_frame*syncSpeed/pulse.length;
//								if (syncType != 0) rel_bar /= sync_beats_per_bar;
//								pos.valid = JackPositionBits.BBT;
//								pos.bar = cast(int) rel_bar;
//								float bar_frac = rel_bar - pos.bar;
//								pos.beat = cast(int) (bar_frac * sync_beats_per_bar);
//								pos.beats_per_bar = sync_beats_per_bar;
//								pos.beats_per_minute = (syncType == 0) ? 
//									sync_beats_per_bar * 60.0 * cast(double) pos.frame_rate/pulse.length:
//									60.0 * cast(double) pos.frame_rate/pulse.length;
//								pos.beat_type = sync_beats_per_bar;
//								pos.ticks_per_beat = ticks_per_beat;
//								float beat_frac = bar_frac*sync_beats_pre_bar - cast(float)pos.beat;
//								pos.tick = cast(int) (beat_frac * ticks_per_beat);
//						
//								pos.bar++;
//								pos.beat++;
//								pos.bar_start_tick = pos.bar * sync_beats_per_bar * ticks_per_beat;
	}
}