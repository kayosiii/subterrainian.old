module sdl.defs;

enum SDLInit 
{ 	
	TIMER = 0x_0000_0001, 
	AUDIO = 0x_0000_0010, 
	VIDEO = 0x_0000_0020, 
	JOYSTICK = 0x_0000_0200,
	HAPTIC = 0x_0000_1000,  
	GAMECONTROLLER = 0x_0000_2000, 
	EVENTS = 0x_0000_4000,  
	NOPARASCHUTE = 0x_0010_0000,
	EVERYTHING = TIMER | AUDIO | VIDEO | EVENTS | JOYSTICK | HAPTIC | GAMECONTROLLER 
}

struct Rect {
	union {		
		struct 
		{
			int x;
			int y;
			int w;
			int h;
		}
		struct
		{
			Point pos;
			Point size;
		}
		int[4] xywh;
	}
}

alias SDL_Rect = Rect;

struct Point {
	union {
		struct 
		{
			int x;
			int y;
		}
		int[2] xy;
	}
}
alias SDL_Point = Point;

struct Color 
{
	union 
	{
		struct
		{
			ubyte r;
			ubyte g;
			ubyte b;
			ubyte a;
		}
		ubyte[4] rgba;
	}
}
alias SDL_Color = Color;

struct TTF_Font;



struct SDL_Palette
{
	int ncolors;
	SDL_Color *colors;
	uint version_;
	int refcount;
}

struct SDL_PixelFormat
{
	uint format;
	SDL_Palette * palette;
	ubyte BitsPerPixel;
	ubyte BytesPerPixel;
	ubyte[2] padding;
	uint Rmask;
	uint Gmask;
	uint Bmask;
	uint Amask;
	ubyte Rloss;
	ubyte Gloss;
	ubyte Bloss;
	ubyte Aloss;
	ubyte Rshift;
	ubyte Gshift;
	ubyte Bshift;
	ubyte Ashift;
	int refcount;
	SDL_PixelFormat * next;
}

struct SDL_Surface
{
	uint flags;
	SDL_PixelFormat *format;
	int w, h;
	int pitch;
	void *pixels;
	void *userdata;
	int locked;
	void *lock_data;
	SDL_Rect clip_rect;
	SDL_BlitMap * map;
	int refcount;
}

enum SDL_RendererFlags
{
	SOFTWARE = 			0x_0000_0001,
	ACCELERATED = 		0x_0000_0002,
	PREVENT_VSYNC = 	0x_0000_0004,
	TARGET_TEXTURE = 	0x_0000_0008
}

enum SDL_BlendMode
{
	none = 	0x_0000_0000,
	blend = 0x_0000_0001,
	add = 	0x_0000_0002,
	mod = 	0x_0000_0004
}

enum SDL_TextureAccess
{
	STATIC,
	STREAMING,
	TARGET
}

enum SDL_bool
{
	FALSE = 0,
	TRUE = 1
}

struct SDL_Renderer;
struct SDL_Texture;
struct SDL_BlitMap;

enum  SDL_WindowFlags
{
	NONE = 0,
	FULLSCREEN = 0x00000001,
	OPENGL = 0x00000002,
	SHOWN = 0x00000004,
	HIDDEN = 0x00000008,
	BORDERLESS = 0x00000010,
	RESIZABLE = 0x00000020,
	MINIMIZED = 0x00000040,
	MAXIMIZED = 0x00000080,
	INPUT_GRABBED = 0x00000100,
	INPUT_FOCUS = 0x00000200,
	MOUSE_FOCUS = 0x00000400,
	FULLSCREEN_DESKTOP = ( FULLSCREEN | 0x00001000 ),
	FOREIGN = 0x00000800,
	ALLOW_HIGHDPI = 0x00002000
}

struct SDL_Window;

//event stuff

enum SDL_EventType
{
	FIRSTEVENT = 0,
	QUIT = 0x100,
	APP_TERMINATING,
	APP_LOWMEMORY,
	APP_WILLENTERBACKGROUND,
	APP_DIDENTERBACKGROUND,
	APP_WILLENTERFOREGROUND,
	APP_DIDENTERFOREGROUND,
	WINDOWEVENT = 0x200,
	SYSWMEVENT,
	KEYDOWN = 0x300,
	KEYUP,
	TEXTEDITING,
	TEXTINPUT,
	MOUSEMOTION = 0x400,
	MOUSEBUTTONDOWN,
	MOUSEBUTTONUP,
	MOUSEWHEEL,
	JOYAXISMOTION = 0x600,
	JOYBALLMOTION,
	JOYHATMOTION,
	JOYBUTTONDOWN,
	JOYBUTTONUP,
	JOYDEVICEADDED,
	JOYDEVICEREMOVED,
	CONTROLLERAXISMOTION = 0x650,
	CONTROLLERBUTTONDOWN,
	CONTROLLERBUTTONUP,
	CONTROLLERDEVICEADDED,
	CONTROLLERDEVICEREMOVED,
	CONTROLLERDEVICEREMAPPED,
	FINGERDOWN = 0x700,
	FINGERUP,
	FINGERMOTION,
	DOLLARGESTURE = 0x800,
	DOLLARRECORD,
	MULTIGESTURE,
	CLIPBOARDUPDATE = 0x900,
	DROPFILE = 0x1000,
	RENDER_TARGETS_RESET = 0x2000,
	USEREVENT = 0x8000,
	LASTEVENT = 0xFFFF
}

enum SDL_Scancode
{
	UNKNOWN = 0,
	A = 4,
	B = 5,
	C = 6,
	D = 7,
	E = 8,
	F = 9,
	G = 10,
	H = 11,
	I = 12,
	J = 13,
	K = 14,
	L = 15,
	M = 16,
	N = 17,
	O = 18,
	P = 19,
	Q = 20,
	R = 21,
	S = 22,
	T = 23,
	U = 24,
	V = 25,
	W = 26,
	X = 27,
	Y = 28,
	Z = 29,
	_1 = 30,
	_2 = 31,
	_3 = 32,
	_4 = 33,
	_5 = 34,
	_6 = 35,
	_7 = 36,
	_8 = 37,
	_9 = 38,
	_0 = 39,
	RETURN = 40,
	ESCAPE = 41,
	BACKSPACE = 42,
	TAB = 43,
	SPACE = 44,
	MINUS = 45,
	EQUALS = 46,
	EQUAL = 46,
	LEFTBRACKET = 47,
	RIGHTBRACKET = 48,
	SQUAREBRACKETCLOSE = 48,
	BACKSLASH = 49,
	NONUSHASH = 50,
	SEMICOLON = 51,
	APOSTROPHE = 52,
	GRAVE = 53,
	COMMA = 54,
	LESSTHAN = 54,
	PERIOD = 55,
	GREATERTHAN = 55,
	SLASH = 56,
	CAPSLOCK = 57,
	F1 = 58,
	F2 = 59,
	F3 = 60,
	F4 = 61,
	F5 = 62,
	F6 = 63,
	F7 = 64,
	F8 = 65,
	F9 = 66,
	F10 = 67,
	F11 = 68,
	F12 = 69,
	PRINTSCREEN = 70,
	SCROLLLOCK = 71,
	PAUSE = 72,
	INSERT = 73,
	HOME = 74,
	PAGEUP = 75,
	DELETE = 76,
	END = 77,
	PAGEDOWN = 78,
	RIGHT = 79,
	LEFT = 80,
	DOWN = 81,
	UP = 82,
	NUMLOCKCLEAR = 83,
	KP_DIVIDE = 84,
	KP_MULTIPLY = 85,
	KP_ASTERISK = 85,
	KP_MINUS = 86,
	KP_PLUS = 87,
	KP_ENTER = 88,
	KP_1 = 89,
	KP_2 = 90,
	KP_3 = 91,
	KP_4 = 92,
	KP_5 = 93,
	KP_6 = 94,
	KP_7 = 95,
	KP_8 = 96,
	KP_9 = 97,
	KP_0 = 98,
	KP_PERIOD = 99,
	NONUSBACKSLASH = 100,
	APPLICATION = 101,
	POWER = 102,
	KP_EQUALS = 103,
	F13 = 104,
	F14 = 105,
	F15 = 106,
	F16 = 107,
	F17 = 108,
	F18 = 109,
	F19 = 110,
	F20 = 111,
	F21 = 112,
	F22 = 113,
	F23 = 114,
	F24 = 115,
	EXECUTE = 116,
	HELP = 117,
	MENU = 118,
	SELECT = 119,
	STOP = 120,
	AGAIN = 121,
	UNDO = 122,
	CUT = 123,
	COPY = 124,
	PASTE = 125,
	FIND = 126,
	MUTE = 127,
	VOLUMEUP = 128,
	VOLUMEDOWN = 129,
	KP_COMMA = 133,
	KP_EQUALSAS400 = 134,
	INTERNATIONAL1 = 135,
	INTERNATIONAL2 = 136,
	INTERNATIONAL3 = 137,
	INTERNATIONAL4 = 138,
	INTERNATIONAL5 = 139,
	INTERNATIONAL6 = 140,
	INTERNATIONAL7 = 141,
	INTERNATIONAL8 = 142,
	INTERNATIONAL9 = 143,
	LANG1 = 144,
	LANG2 = 145,
	LANG3 = 146,
	LANG4 = 147,
	LANG5 = 148,
	LANG6 = 149,
	LANG7 = 150,
	LANG8 = 151,
	LANG9 = 152,
	ALTERASE = 153,
	SYSREQ = 154,
	CANCEL = 155,
	CLEAR = 156,
	PRIOR = 157,
	RETURN2 = 158,
	SEPARATOR = 159,
	OUT = 160,
	OPER = 161,
	CLEARAGAIN = 162,
	CRSEL = 163,
	EXSEL = 164,
	KP_00 = 176,
	KP_000 = 177,
	THOUSANDSSEPARATOR = 178,
	DECIMALSEPARATOR = 179,
	CURRENCYUNIT = 180,
	CURRENCYSUBUNIT = 181,
	KP_LEFTPAREN = 182,
	KP_RIGHTPAREN = 183,
	KP_LEFTBRACE = 184,
	KP_RIGHTBRACE = 185,
	KP_TAB = 186,
	KP_BACKSPACE = 187,
	KP_A = 188,
	KP_B = 189,
	KP_C = 190,
	KP_D = 191,
	KP_E = 192,
	KP_F = 193,
	KP_XOR = 194,
	KP_POWER = 195,
	KP_PERCENT = 196,
	KP_LESS = 197,
	KP_GREATER = 198,
	KP_AMPERSAND = 199,
	KP_DBLAMPERSAND = 200,
	KP_VERTICALBAR = 201,
	KP_DBLVERTICALBAR = 202,
	KP_COLON = 203,
	KP_HASH = 204,
	KP_SPACE = 205,
	KP_AT = 206,
	KP_EXCLAM = 207,
	KP_MEMSTORE = 208,
	KP_MEMRECALL = 209,
	KP_MEMCLEAR = 210,
	KP_MEMADD = 211,
	KP_MEMSUBTRACT = 212,
	KP_MEMMULTIPLY = 213,
	KP_MEMDIVIDE = 214,
	KP_PLUSMINUS = 215,
	KP_CLEAR = 216,
	KP_CLEARENTRY = 217,
	KP_BINARY = 218,
	KP_OCTAL = 219,
	KP_DECIMAL = 220,
	KP_HEXADECIMAL = 221,
	LCTRL = 224,
	LSHIFT = 225,
	LALT = 226,
	LGUI = 227,
	RCTRL = 228,
	RSHIFT = 229,
	RALT = 230,
	RGUI = 231,
	MODE = 257,
	AUDIONEXT = 258,
	AUDIOPREV = 259,
	AUDIOSTOP = 260,
	AUDIOPLAY = 261,
	AUDIOMUTE = 262,
	MEDIASELECT = 263,
	WWW = 264,
	MAIL = 265,
	CALCULATOR = 266,
	COMPUTER = 267,
	AC_SEARCH = 268,
	AC_HOME = 269,
	AC_BACK = 270,
	AC_FORWARD = 271,
	AC_STOP = 272,
	AC_REFRESH = 273,
	AC_BOOKMARKS = 274,
	BRIGHTNESSDOWN = 275,
	BRIGHTNESSUP = 276,
	DISPLAYSWITCH = 277,
	KBDILLUMTOGGLE = 278,
	KBDILLUMDOWN = 279,
	KBDILLUMUP = 280,
	EJECT = 281,
	SLEEP = 282,
	APP1 = 283,
	APP2 = 284,
	NUM_SCANCODES = 512
}

enum SDL_Keycode
{
	UNKNOWN = 0,
	RETURN = '\r',
	ESCAPE = '\033',
	BACKSPACE = '\b',
	TAB = '\t',
	SPACE = ' ',
	EXCLAIM = '!',
	QUOTEDBL = '"',
	HASH = '#',
	PERCENT = '%',
	DOLLAR = '$',
	AMPERSAND = '&',
	QUOTE = '\'',
	LEFTPAREN = '(',
	RIGHTPAREN = ')',
	ASTERISK = '*',
	PLUS = '+',
	COMMA = ',',
	MINUS = '-',
	PERIOD = '.',
	SLASH = '/',
	_0 = '0',
	_1 = '1',
	_2 = '2',
	_3 = '3',
	_4 = '4',
	_5 = '5',
	_6 = '6',
	_7 = '7',
	_8 = '8',
	_9 = '9',
	COLON = ':',
	SEMICOLON = ';',
	LESS = '<',
	EQUALS = '=',
	GREATER = '>',
	QUESTION = '?',
	AT = '@',
	LEFTBRACKET = '[',
	BACKSLASH = '\\',
	RIGHTBRACKET = ']',
	CARET = '^',
	UNDERSCORE = '_',
	BACKQUOTE = '`',
	a = 'a',
	b = 'b',
	c = 'c',
	d = 'd',
	e = 'e',
	f = 'f',
	g = 'g',
	h = 'h',
	i = 'i',
	j = 'j',
	k = 'k',
	l = 'l',
	m = 'm',
	n = 'n',
	o = 'o',
	p = 'p',
	q = 'q',
	r = 'r',
	s = 's',
	t = 't',
	u = 'u',
	v = 'v',
	w = 'w',
	x = 'x',
	y = 'y',
	z = 'z',
	CAPSLOCK = (SDL_Scancode.CAPSLOCK | (1<<30)),
	F1 = (SDL_Scancode.F1 | (1<<30)),
	F2 = (SDL_Scancode.F2 | (1<<30)),
	F3 = (SDL_Scancode.F3 | (1<<30)),
	F4 = (SDL_Scancode.F4 | (1<<30)),
	F5 = (SDL_Scancode.F5 | (1<<30)),
	F6 = (SDL_Scancode.F6 | (1<<30)),
	F7 = (SDL_Scancode.F7 | (1<<30)),
	F8 = (SDL_Scancode.F8 | (1<<30)),
	F9 = (SDL_Scancode.F9 | (1<<30)),
	F10 = (SDL_Scancode.F10 | (1<<30)),
	F11 = (SDL_Scancode.F11 | (1<<30)),
	F12 = (SDL_Scancode.F12 | (1<<30)),
	PRINTSCREEN = (SDL_Scancode.PRINTSCREEN | (1<<30)),
	SCROLLLOCK = (SDL_Scancode.SCROLLLOCK | (1<<30)),
	PAUSE = (SDL_Scancode.PAUSE | (1<<30)),
	INSERT = (SDL_Scancode.INSERT | (1<<30)),
	HOME = (SDL_Scancode.HOME | (1<<30)),
	PAGEUP = (SDL_Scancode.PAGEUP | (1<<30)),
	DELETE = '\177',
	END = (SDL_Scancode.END | (1<<30)),
	PAGEDOWN = (SDL_Scancode.PAGEDOWN | (1<<30)),
	RIGHT = (SDL_Scancode.RIGHT | (1<<30)),
	LEFT = (SDL_Scancode.LEFT | (1<<30)),
	DOWN = (SDL_Scancode.DOWN | (1<<30)),
	UP = (SDL_Scancode.UP | (1<<30)),
	NUMLOCKCLEAR = (SDL_Scancode.NUMLOCKCLEAR | (1<<30)),
	KP_DIVIDE = (SDL_Scancode.KP_DIVIDE | (1<<30)),
	KP_MULTIPLY = (SDL_Scancode.KP_MULTIPLY | (1<<30)),
	KP_MINUS = (SDL_Scancode.KP_MINUS | (1<<30)),
	KP_PLUS = (SDL_Scancode.KP_PLUS | (1<<30)),
	KP_ENTER = (SDL_Scancode.KP_ENTER | (1<<30)),
	KP_1 = (SDL_Scancode.KP_1 | (1<<30)),
	KP_2 = (SDL_Scancode.KP_2 | (1<<30)),
	KP_3 = (SDL_Scancode.KP_3 | (1<<30)),
	KP_4 = (SDL_Scancode.KP_4 | (1<<30)),
	KP_5 = (SDL_Scancode.KP_5 | (1<<30)),
	KP_6 = (SDL_Scancode.KP_6 | (1<<30)),
	KP_7 = (SDL_Scancode.KP_7 | (1<<30)),
	KP_8 = (SDL_Scancode.KP_8 | (1<<30)),
	KP_9 = (SDL_Scancode.KP_9 | (1<<30)),
	KP_0 = (SDL_Scancode.KP_0 | (1<<30)),
	KP_PERIOD = (SDL_Scancode.KP_PERIOD | (1<<30)),
	APPLICATION = (SDL_Scancode.APPLICATION | (1<<30)),
	POWER = (SDL_Scancode.POWER | (1<<30)),
	KP_EQUALS = (SDL_Scancode.KP_EQUALS | (1<<30)),
	F13 = (SDL_Scancode.F13 | (1<<30)),
	F14 = (SDL_Scancode.F14 | (1<<30)),
	F15 = (SDL_Scancode.F15 | (1<<30)),
	F16 = (SDL_Scancode.F16 | (1<<30)),
	F17 = (SDL_Scancode.F17 | (1<<30)),
	F18 = (SDL_Scancode.F18 | (1<<30)),
	F19 = (SDL_Scancode.F19 | (1<<30)),
	F20 = (SDL_Scancode.F20 | (1<<30)),
	F21 = (SDL_Scancode.F21 | (1<<30)),
	F22 = (SDL_Scancode.F22 | (1<<30)),
	F23 = (SDL_Scancode.F23 | (1<<30)),
	F24 = (SDL_Scancode.F24 | (1<<30)),
	EXECUTE = (SDL_Scancode.EXECUTE | (1<<30)),
	HELP = (SDL_Scancode.HELP | (1<<30)),
	MENU = (SDL_Scancode.MENU | (1<<30)),
	SELECT = (SDL_Scancode.SELECT | (1<<30)),
	STOP = (SDL_Scancode.STOP | (1<<30)),
	AGAIN = (SDL_Scancode.AGAIN | (1<<30)),
	UNDO = (SDL_Scancode.UNDO | (1<<30)),
	CUT = (SDL_Scancode.CUT | (1<<30)),
	COPY = (SDL_Scancode.COPY | (1<<30)),
	PASTE = (SDL_Scancode.PASTE | (1<<30)),
	FIND = (SDL_Scancode.FIND | (1<<30)),
	MUTE = (SDL_Scancode.MUTE | (1<<30)),
	VOLUMEUP = (SDL_Scancode.VOLUMEUP | (1<<30)),
	VOLUMEDOWN = (SDL_Scancode.VOLUMEDOWN | (1<<30)),
	KP_COMMA = (SDL_Scancode.KP_COMMA | (1<<30)),
	KP_EQUALSAS400 =
	(SDL_Scancode.KP_EQUALSAS400 | (1<<30)),
	ALTERASE = (SDL_Scancode.ALTERASE | (1<<30)),
	SYSREQ = (SDL_Scancode.SYSREQ | (1<<30)),
	CANCEL = (SDL_Scancode.CANCEL | (1<<30)),
	CLEAR = (SDL_Scancode.CLEAR | (1<<30)),
	PRIOR = (SDL_Scancode.PRIOR | (1<<30)),
	RETURN2 = (SDL_Scancode.RETURN2 | (1<<30)),
	SEPARATOR = (SDL_Scancode.SEPARATOR | (1<<30)),
	OUT = (SDL_Scancode.OUT | (1<<30)),
	OPER = (SDL_Scancode.OPER | (1<<30)),
	CLEARAGAIN = (SDL_Scancode.CLEARAGAIN | (1<<30)),
	CRSEL = (SDL_Scancode.CRSEL | (1<<30)),
	EXSEL = (SDL_Scancode.EXSEL | (1<<30)),
	KP_00 = (SDL_Scancode.KP_00 | (1<<30)),
	KP_000 = (SDL_Scancode.KP_000 | (1<<30)),
	THOUSANDSSEPARATOR =
	(SDL_Scancode.THOUSANDSSEPARATOR | (1<<30)),
	DECIMALSEPARATOR =
	(SDL_Scancode.DECIMALSEPARATOR | (1<<30)),
	CURRENCYUNIT = (SDL_Scancode.CURRENCYUNIT | (1<<30)),
	CURRENCYSUBUNIT =
	(SDL_Scancode.CURRENCYSUBUNIT | (1<<30)),
	KP_LEFTPAREN = (SDL_Scancode.KP_LEFTPAREN | (1<<30)),
	KP_RIGHTPAREN = (SDL_Scancode.KP_RIGHTPAREN | (1<<30)),
	KP_LEFTBRACE = (SDL_Scancode.KP_LEFTBRACE | (1<<30)),
	KP_RIGHTBRACE = (SDL_Scancode.KP_RIGHTBRACE | (1<<30)),
	KP_TAB = (SDL_Scancode.KP_TAB | (1<<30)),
	KP_BACKSPACE = (SDL_Scancode.KP_BACKSPACE | (1<<30)),
	KP_A = (SDL_Scancode.KP_A | (1<<30)),
	KP_B = (SDL_Scancode.KP_B | (1<<30)),
	KP_C = (SDL_Scancode.KP_C | (1<<30)),
	KP_D = (SDL_Scancode.KP_D | (1<<30)),
	KP_E = (SDL_Scancode.KP_E | (1<<30)),
	KP_F = (SDL_Scancode.KP_F | (1<<30)),
	KP_XOR = (SDL_Scancode.KP_XOR | (1<<30)),
	KP_POWER = (SDL_Scancode.KP_POWER | (1<<30)),
	KP_PERCENT = (SDL_Scancode.KP_PERCENT | (1<<30)),
	KP_LESS = (SDL_Scancode.KP_LESS | (1<<30)),
	KP_GREATER = (SDL_Scancode.KP_GREATER | (1<<30)),
	KP_AMPERSAND = (SDL_Scancode.KP_AMPERSAND | (1<<30)),
	KP_DBLAMPERSAND =
	(SDL_Scancode.KP_DBLAMPERSAND | (1<<30)),
	KP_VERTICALBAR =
	(SDL_Scancode.KP_VERTICALBAR | (1<<30)),
	KP_DBLVERTICALBAR =
	(SDL_Scancode.KP_DBLVERTICALBAR | (1<<30)),
	KP_COLON = (SDL_Scancode.KP_COLON | (1<<30)),
	KP_HASH = (SDL_Scancode.KP_HASH | (1<<30)),
	KP_SPACE = (SDL_Scancode.KP_SPACE | (1<<30)),
	KP_AT = (SDL_Scancode.KP_AT | (1<<30)),
	KP_EXCLAM = (SDL_Scancode.KP_EXCLAM | (1<<30)),
	KP_MEMSTORE = (SDL_Scancode.KP_MEMSTORE | (1<<30)),
	KP_MEMRECALL = (SDL_Scancode.KP_MEMRECALL | (1<<30)),
	KP_MEMCLEAR = (SDL_Scancode.KP_MEMCLEAR | (1<<30)),
	KP_MEMADD = (SDL_Scancode.KP_MEMADD | (1<<30)),
	KP_MEMSUBTRACT =
	(SDL_Scancode.KP_MEMSUBTRACT | (1<<30)),
	KP_MEMMULTIPLY =
	(SDL_Scancode.KP_MEMMULTIPLY | (1<<30)),
	KP_MEMDIVIDE = (SDL_Scancode.KP_MEMDIVIDE | (1<<30)),
	KP_PLUSMINUS = (SDL_Scancode.KP_PLUSMINUS | (1<<30)),
	KP_CLEAR = (SDL_Scancode.KP_CLEAR | (1<<30)),
	KP_CLEARENTRY = (SDL_Scancode.KP_CLEARENTRY | (1<<30)),
	KP_BINARY = (SDL_Scancode.KP_BINARY | (1<<30)),
	KP_OCTAL = (SDL_Scancode.KP_OCTAL | (1<<30)),
	KP_DECIMAL = (SDL_Scancode.KP_DECIMAL | (1<<30)),
	KP_HEXADECIMAL =
	(SDL_Scancode.KP_HEXADECIMAL | (1<<30)),
	LCTRL = (SDL_Scancode.LCTRL | (1<<30)),
	LSHIFT = (SDL_Scancode.LSHIFT | (1<<30)),
	LALT = (SDL_Scancode.LALT | (1<<30)),
	LGUI = (SDL_Scancode.LGUI | (1<<30)),
	RCTRL = (SDL_Scancode.RCTRL | (1<<30)),
	RSHIFT = (SDL_Scancode.RSHIFT | (1<<30)),
	RALT = (SDL_Scancode.RALT | (1<<30)),
	RGUI = (SDL_Scancode.RGUI | (1<<30)),
	MODE = (SDL_Scancode.MODE | (1<<30)),
	AUDIONEXT = (SDL_Scancode.AUDIONEXT | (1<<30)),
	AUDIOPREV = (SDL_Scancode.AUDIOPREV | (1<<30)),
	AUDIOSTOP = (SDL_Scancode.AUDIOSTOP | (1<<30)),
	AUDIOPLAY = (SDL_Scancode.AUDIOPLAY | (1<<30)),
	AUDIOMUTE = (SDL_Scancode.AUDIOMUTE | (1<<30)),
	MEDIASELECT = (SDL_Scancode.MEDIASELECT | (1<<30)),
	WWW = (SDL_Scancode.WWW | (1<<30)),
	MAIL = (SDL_Scancode.MAIL | (1<<30)),
	CALCULATOR = (SDL_Scancode.CALCULATOR | (1<<30)),
	COMPUTER = (SDL_Scancode.COMPUTER | (1<<30)),
	AC_SEARCH = (SDL_Scancode.AC_SEARCH | (1<<30)),
	AC_HOME = (SDL_Scancode.AC_HOME | (1<<30)),
	AC_BACK = (SDL_Scancode.AC_BACK | (1<<30)),
	AC_FORWARD = (SDL_Scancode.AC_FORWARD | (1<<30)),
	AC_STOP = (SDL_Scancode.AC_STOP | (1<<30)),
	AC_REFRESH = (SDL_Scancode.AC_REFRESH | (1<<30)),
	AC_BOOKMARKS = (SDL_Scancode.AC_BOOKMARKS | (1<<30)),
	BRIGHTNESSDOWN =
	(SDL_Scancode.BRIGHTNESSDOWN | (1<<30)),
	BRIGHTNESSUP = (SDL_Scancode.BRIGHTNESSUP | (1<<30)),
	DISPLAYSWITCH = (SDL_Scancode.DISPLAYSWITCH | (1<<30)),
	KBDILLUMTOGGLE =
	(SDL_Scancode.KBDILLUMTOGGLE | (1<<30)),
	KBDILLUMDOWN = (SDL_Scancode.KBDILLUMDOWN | (1<<30)),
	KBDILLUMUP = (SDL_Scancode.KBDILLUMUP | (1<<30)),
	EJECT = (SDL_Scancode.EJECT | (1<<30)),
	SLEEP = (SDL_Scancode.SLEEP | (1<<30))
};
enum SDL_Keymod
{
	NONE = 0x0000,
	LSHIFT = 0x0001,
	RSHIFT = 0x0002,
	LCTRL = 0x0040,
	RCTRL = 0x0080,
	LALT = 0x0100,
	RALT = 0x0200,
	LGUI = 0x0400,
	RGUI = 0x0800,
	NUM = 0x1000,
	CAPS = 0x2000,
	MODE = 0x4000,
	RESERVED = 0x8000
}
struct SDL_Keysym
{
	SDL_Scancode scancode;
	SDL_Keycode sym;
	ushort mod;
	uint unused;
}

struct SDL_CommonEvent
{
	uint type;
	uint timestamp;
}
struct SDL_WindowEvent
{
	uint type;
	uint timestamp;
	uint windowID;
	ubyte event;
	ubyte padding1;
	ubyte padding2;
	ubyte padding3;
	int data1;
	int data2;
}
struct SDL_KeyboardEvent
{
	uint type;
	uint timestamp;
	uint windowID;
	ubyte state;
	ubyte repeat;
	ubyte padding2;
	ubyte padding3;
	SDL_Keysym keysym;
}
struct SDL_TextEditingEvent
{
	uint type;
	uint timestamp;
	uint windowID;
	char[(32)] text;
	int start;
	int length;
}
struct SDL_TextInputEvent
{
	uint type;
	uint timestamp;
	uint windowID;
	char[(32)] text;
}
struct SDL_MouseMotionEvent
{
	uint type;
	uint timestamp;
	uint windowID;
	uint which;
	uint state;
	int x;
	int y;
	int xrel;
	int yrel;
}
struct SDL_MouseButtonEvent
{
	uint type;
	uint timestamp;
	uint windowID;
	uint which;
	ubyte button;
	ubyte state;
	ubyte clicks;
	ubyte padding1;
	int x;
	int y;
}
struct SDL_MouseWheelEvent
{
	uint type;
	uint timestamp;
	uint windowID;
	uint which;
	int x;
	int y;
}
struct _SDL_Joystick;
alias _SDL_Joystick SDL_Joystick;
struct SDL_JoystickGUID { ubyte[16] data; }
alias int SDL_JoystickID;

alias long SDL_TouchID;
alias long SDL_FingerID;
struct SDL_Finger
{
	SDL_FingerID id;
	float x;
	float y;
	float pressure;
}

alias long SDL_GestureID;

struct SDL_JoyAxisEvent
{
	uint type;
	uint timestamp;
	SDL_JoystickID which;
	ubyte axis;
	ubyte padding1;
	ubyte padding2;
	ubyte padding3;
	short value;
	ushort padding4;
}
struct SDL_JoyBallEvent
{
	uint type;
	uint timestamp;
	SDL_JoystickID which;
	ubyte ball;
	ubyte padding1;
	ubyte padding2;
	ubyte padding3;
	short xrel;
	short yrel;
}
struct SDL_JoyHatEvent
{
	uint type;
	uint timestamp;
	SDL_JoystickID which;
	ubyte hat;
	ubyte value;
	ubyte padding1;
	ubyte padding2;
}
struct SDL_JoyButtonEvent
{
	uint type;
	uint timestamp;
	SDL_JoystickID which;
	ubyte button;
	ubyte state;
	ubyte padding1;
	ubyte padding2;
}
struct SDL_JoyDeviceEvent
{
	uint type;
	uint timestamp;
	int which;
}
struct SDL_ControllerAxisEvent
{
	uint type;
	uint timestamp;
	SDL_JoystickID which;
	ubyte axis;
	ubyte padding1;
	ubyte padding2;
	ubyte padding3;
	short value;
	ushort padding4;
}
struct SDL_ControllerButtonEvent
{
	uint timestamp;
	SDL_JoystickID which;
	ubyte button;
	ubyte state;
	ubyte padding1;
	ubyte padding2;
}
struct SDL_ControllerDeviceEvent
{
	uint type;
	uint timestamp;
	int which;
}
struct SDL_TouchFingerEvent
{
	uint type;
	uint timestamp;
	SDL_TouchID touchId;
	SDL_FingerID fingerId;
	float x;
	float y;
	float dx;
	float dy;
	float pressure;
}
struct SDL_MultiGestureEvent
{
	uint type;
	uint timestamp;
	SDL_TouchID touchId;
	float dTheta;
	float dDist;
	float x;
	float y;
	ushort numFingers;
	ushort padding;
}
struct SDL_DollarGestureEvent
{
	uint type;
	uint timestamp;
	SDL_TouchID touchId;
	SDL_GestureID gestureId;
	uint numFingers;
	float error;
	float x;
	float y;
}
struct SDL_DropEvent
{
	uint type;
	uint timestamp;
	char *file;
}
struct SDL_QuitEvent
{
	uint type;
	uint timestamp;
}
struct SDL_OSEvent
{
	uint type;
	uint timestamp;
}
struct SDL_UserEvent
{
	uint type;
	uint timestamp;
	uint windowID;
	int code;
	void *data1;
	void *data2;
}

//alias SDL_SysWMmsg SDL_SysWMmsg;

struct SDL_SysWMEvent
{
	uint type;
	uint timestamp;
	//	SDL_SysWMmsg *msg;
}
union SDL_Event
{
	uint type;
	SDL_CommonEvent common;
	SDL_WindowEvent window;
	SDL_KeyboardEvent key;
	SDL_TextEditingEvent edit;
	SDL_TextInputEvent text;
	SDL_MouseMotionEvent motion;
	SDL_MouseButtonEvent button;
	SDL_MouseWheelEvent wheel;
	SDL_JoyAxisEvent jaxis;
	SDL_JoyBallEvent jball;
	SDL_JoyHatEvent jhat;
	SDL_JoyButtonEvent jbutton;
	SDL_JoyDeviceEvent jdevice;
	SDL_ControllerAxisEvent caxis;
	SDL_ControllerButtonEvent cbutton;
	SDL_ControllerDeviceEvent cdevice;
	SDL_QuitEvent quit;
	SDL_UserEvent user;
	SDL_SysWMEvent syswm;
	SDL_TouchFingerEvent tfinger;
	SDL_MultiGestureEvent mgesture;
	SDL_DollarGestureEvent dgesture;
	SDL_DropEvent drop;
	ubyte[56] padding;
}