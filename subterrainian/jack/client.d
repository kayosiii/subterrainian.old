module jack.client;

import std.conv : to;

public import jack.defs : JackClient, JackOptions, JackStatus, JackTransportState, jack_position_t, JackPositionBits;
import jack.defs : jack_port_t;
import jack.c;
import std.string : toStringz;

//import memory;

alias jack_port_t * JackPort;
//struct JackPort
//{
//	jack_port_t * port;
////	char[] name;
//	string name;
//	alias port this;
//}

pragma(inline) @trusted nothrow
{
	JackClient open(char * name, JackOptions options, out JackStatus status) @nogc
	{
		return jack_client_open (name,options,&status);
	}

	JackClient open(string name, JackOptions options, out JackStatus status)
	{
		return jack_client_open( name.toStringz, options, &status );
	}
	
	bool close(JackClient client) @nogc 
	{
		auto r = ! cast(bool) jack_client_close(client);
		return r;
	}

	bool activate (JackClient client) @nogc  { return ! cast(bool) jack_activate(client); }
	bool deactivate (JackClient client) @nogc  { return ! cast(bool) jack_deactivate(client); }
}

// get ports
@trusted
{
	import jack.defs : JackPortFlags, JACK_DEFAULT_AUDIO_TYPE;

	JackPort registerPort(JackClient client, string name, char * type, JackPortFlags flags)
	{
		return jack_port_register(client,name.toStringz,type,flags,0);
	}
	JackPort registerPort(JackClient client, immutable(char)* name, char * type, JackPortFlags flags) @nogc
	{
		return jack_port_register(client,name,type,flags,0);
	}

	bool unregisterPort(JackClient client, JackPort port) @nogc
	{
		return ! cast(bool) jack_port_unregister(client,port);
	}

	alias getPorts = jack_get_ports;
}

//utility functions
pragma(inline) @trusted
{
	alias getSampleRate = jack_get_sample_rate;
	alias getBufferSize = jack_get_buffer_size;

	float CPULoad (JackClient client) @nogc pure nothrow @safe { return jack_cpu_load(client);}

}

//Transport functions
pragma(inline) @trusted
{
	JackTransportState queryTransport(JackClient client, ref jack_position_t pos)
	{
		return jack_transport_query(client,&pos);
	}
	alias locateTransport = jack_transport_locate;
}

// callbacks
pragma(inline) @trusted @nogc
{
	public import jack.defs : JackProcessCallback, JackSamplerateCallback,JackShutdownCallback,JackTimebaseCallback;
	bool setProcessCallback(JackClient client, JackProcessCallback cb) 
	{
		return ! cast(bool) jack_set_process_callback(client,cb,null);
	}
	bool setSamplerateCallback(JackClient client, JackSamplerateCallback cb)
	{
		return ! cast(bool) jack_set_sample_rate_callback(client,cb,null);
	}
	void onShutdownCallback(JackClient client, JackShutdownCallback cb)
	{
		jack_on_shutdown(client,cb,null);
	}
	public import std.typecons : Flag, Yes, No;
	bool setTimebaseCallback(Flag!"Conditional" conditional)(JackClient client, JackTimebaseCallback cb)
	{
		static if (conditional) return ! cast(bool) jack_set_timebase_callback(client,1,cb,null);
		else return ! cast(bool) jack_set_timebase_callback(client,0,cb,null);
	}
}