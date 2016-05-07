module mixer;

import std.experimental.allocator.mallocator : Mallocator;
import std.experimental.allocator : make, makeArray, dispose;
import jack.port, jack.client;
import types;

struct AudioChannel
{
	immutable(char)* name;
	JackPort port;
	sample_t [] buffer;
	
	@property bool empty() {return (buffer.length == 0);}
	@property front() {return buffer[0];}
	void popFront() { buffer = buffer[1..$];}
}

struct AudioStream
{
	float volume;
	float delta_volume;
	float target_volume;
	float pos;
	AudioChannel [] channels;
	
}

__gshared
{
	AudioStream [] inputs;
	AudioStream main;
	AudioStream [] aux;
}



shared static this()
{
	inputs = Mallocator.instance.makeArray!AudioStream(1);
	inputs[0].channels = Mallocator.instance.makeArray!AudioChannel(1);
	foreach (ref channel; inputs[0].channels)
	{
		channel.name = "input_1".toStringz;
	}
	main.channels = Mallocator.instance.makeArray!AudioChannel(2);
	foreach (i, ref channel; main.channels)
	{
		auto ch = i ? "r" : "l";
		channel.name = ("main_" ~ ch).toStringz;
	}
}

shared static ~this()
{
	foreach (stream; inputs) Mallocator.instance.dispose(stream.channels);
	Mallocator.instance.dispose(inputs);

	foreach (stream; aux) Mallocator.instance.dispose(stream.channels);
	Mallocator.instance.dispose(aux);

	Mallocator.instance.dispose(main.channels);
}
