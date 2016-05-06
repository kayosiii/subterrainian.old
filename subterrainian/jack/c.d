module jack.c;

import jack.defs;

@trusted extern(C) nothrow @nogc 
{
	jack_client_t * jack_client_open (const char *client_name, jack_options_t options, jack_status_t *status, ...) @nogc nothrow ;
	int jack_client_close (jack_client_t *client)@nogc nothrow ;

	jack_port_t * jack_port_register (jack_client_t *client, const char *port_name, const char *port_type, ulong flags, ulong buffer_size) ;
	int jack_port_unregister (jack_client_t *, jack_port_t *);
	void * jack_port_get_buffer (jack_port_t *port, jack_nframes_t);

	int jack_set_process_callback (jack_client_t *client, JackProcessCallback process_callback, void *arg) ;
	int jack_set_sample_rate_callback (jack_client_t *client, JackSamplerateCallback srate_callback, void *arg) ;
	int jack_set_timebase_callback (jack_client_t *client, int conditional, JackTimebaseCallback timebase_callback, void *arg) ;
	void jack_on_shutdown (jack_client_t *client, JackShutdownCallback shutdown_callback, void *arg) ;

	jack_nframes_t jack_get_sample_rate (jack_client_t *);
	jack_nframes_t jack_get_buffer_size (jack_client_t *);

	jack_transport_state_t jack_transport_query (const jack_client_t *client, jack_position_t *pos);


	int jack_activate (jack_client_t *client);
	int jack_deactivate (jack_client_t *client);

	pure float jack_cpu_load ( jack_client_t * client );

	void  ** jack_get_ports (jack_client_t *client, const char *port_name_pattern, const char *type_name_pattern, ulong flags);
	int  jack_transport_locate (jack_client_t *client, jack_nframes_t frame);
}

