#!/usr/bin/rdmd --shebang -debug=main -L-ljack -lx11 -lSDL2 -lSDL2_ttf
module subterrainian;
debug = main;

debug (main) import std.stdio : stdin, readln, writeln;
void go ()
{


	debug (main)
	{
		import core.thread : Thread;
		import core.time : msecs;
		Thread.sleep(msecs(3200));
	} 
	else
	{

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

