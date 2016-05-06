#!/usr/bin/rdmd --shebang -debug=main -L-ljack -lx11 -lSDL2 -lSDL2_ttf
module subterrainian;
import video;

import std.exception : enforce;

import sdl.main;
import xlib, input;

version = X11;
//debug = main;

debug (main) import std.stdio : stdin, readln, writeln;

void go ()
{
	version (X11) { enforce (xlib.initThreads, "CORE: xlib needs to be multithreaded\n"); }
	else { assert (0,"CORE: Currently on XWindows is supported\n"); }
	enforce (sdl.main.init(SDLInit.VIDEO|SDLInit.JOYSTICK), "CORE: SDL failed to start\n"); 

	video.start;
	scope (exit) video.stop;

	debug (main)
	{
		import core.thread : Thread;
		import core.time : msecs;
		Thread.sleep(msecs(3200));
	} 
	else
	{
		input.start();
	}
}

void main(string[] args)
{
	subterrainian.go();

	debug (main)
	{
		// Prints "Hello World" string in console
		writeln("Hello World!");
	
		// Lets the user press <Return> before program returns
		stdin.readln();
	}
}

