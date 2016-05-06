module sdl.window;

import std.string : toStringz;

public import sdl.defs : SDL_Window, SDL_WindowFlags, SDL_Rect;
import sdl.c;

pragma(inline):

SDL_Window * create(string title, int x, int y, int w, int h, uint flags)
{ return SDL_CreateWindow(title.toStringz,x,y,w,h,flags); }
SDL_Window * create(string title, SDL_Rect w, uint flags)
{
	return SDL_CreateWindow(title.toStringz,w.x,w.y,w.w,w.h,flags);
}

alias destroy = SDL_DestroyWindow;
