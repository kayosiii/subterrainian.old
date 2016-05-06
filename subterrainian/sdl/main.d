module sdl.main;

public import sdl.defs : SDLInit;
import sdl.c;

pragma(inline):

bool init (uint flags) { return ! cast(bool) SDL_Init(flags); }
bool initSubsystem (uint flags) { return ! cast(bool) SDL_InitSubSystem(flags);}
void quitSubsystem (uint flags) { SDL_QuitSubSystem(flags); }
void quit() { sdl.c.SDL_Quit(); }
