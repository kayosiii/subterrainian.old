module jack.defs;

enum char * JACK_DEFAULT_AUDIO_TYPE = ['3','2',' ','b','i','t',' ','f','l','o','a','t',' ','m','o','n','o',' ','a','u','d','i','o','\0'];
enum char * JACK_DEFAULT_MIDI_TYPE = ['8',' ','b','i','t',' ','r','a','w',' ','m','i','d','i','\0'];


alias uint jack_nframes_t;
alias float jack_default_audio_sample_t;

struct jack_client_t;
alias jack_client_t * JackClient;

enum JackPortFlags {
	IsInput = 0x1,
	IsOutput = 0x2,
	IsPhysical = 0x4,
	CanMonitor = 0x8,
	IsTerminal = 0x10,
}
struct jack_port_t;

enum JackOptions {
	NullOption = 0x00,
	NoStartServer = 0x01,
	UseExactName = 0x02,
	ServerName = 0x04,
	LoadName = 0x08,
	LoadInit = 0x10,
	SessionID = 0x20
}
alias JackOptions jack_options_t;

enum JackStatus {
	Failure = 0x01,
	InvalidOption = 0x02,
	NameNotUnique = 0x04,
	ServerStarted = 0x08,
	ServerFailed = 0x10,
	ServerError = 0x20,
	NoSuchClient = 0x40,
	LoadFailure = 0x80,
	InitFailure = 0x100,
	ShmFailure = 0x200,
	VersionError = 0x400,
	BackendError = 0x800,
	ClientZombie = 0x1000
}
alias JackStatus jack_status_t;
alias long jack_unique_t;
alias long jack_time_t;

enum jack_position_bits_t {
	BBT = 0x10, 
	TimeCode=0x20, 
	BBTFrameOffset=0x40, 
	AudioVideoRatio=0x80,
	VideoFrameOffset = 0x100
}
alias jack_position_bits_t JackPositionBits;

struct _jack_position
{
	jack_unique_t unique_1;
	jack_time_t usecs;
	jack_nframes_t frame_rate;
	jack_nframes_t frame;
	jack_position_bits_t valid;
	int bar;
	int beat;
	int tick;
	double bar_start_tick;
	float beats_per_bar;
	float beat_type;
	double ticks_per_beat;
	double beats_per_minute;
	double frame_time;
	double next_time;
	jack_nframes_t bbt_offset;
	float audio_frames_per_video_frame;
	jack_nframes_t video_offset;
	int[7] padding;
	jack_unique_t unique_2;
}
alias _jack_position jack_position_t;
alias _jack_position JackPosition;

enum jack_transport_state_t {
	Stopped = 0, Rolling = 1, Looping = 2, Starting = 3, NetStarting = 4
};
alias jack_transport_state_t JackTransportState;

extern (C) 
{
	alias JackProcessCallback = int function (jack_nframes_t nframes, void * arg);
	alias JackSamplerateCallback = int function (jack_nframes_t nframes, void * arg);
	alias JackShutdownCallback = void function (void *arg);
	alias JackTimebaseCallback = void function (JackTransportState state, jack_nframes_t nframes, jack_position_t *pos, int new_pos, void *arg);
}

