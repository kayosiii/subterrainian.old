module video;

import core.thread : Thread,Mutex;
import core.time : msecs, Duration;

import std.experimental.allocator : theAllocator, make, dispose;

import sdl.main, sdl.window, sdl.renderer;
import sdl.defs : Rect;

void start()
{
	lock = theAllocator.make!Mutex();
	thread = theAllocator.make!Thread(&run_thread,128*1024);
	thread.priority = Thread.PRIORITY_MIN;
	thread.name = "Video";
	thread.start();
}

void stop()
{
	running = false;
	while (thread.isRunning) Thread.sleep(msecs(10));
	theAllocator.dispose(thread);
	theAllocator.dispose(lock);
}

private
{
	Thread thread;
	__gshared Mutex lock;
	__gshared bool running;
	SDL_Window * window;
	SDL_Renderer * renderer;
	immutable Rect screen = Rect(100,100,800,480);
	immutable Duration delay = msecs(40);
}

private
{
	void run_thread()
	{
		video.running = true;

		version(linux)
		{
			synchronized (lock)
			{
				window = sdl.window.create ("subterrainian", screen, SDL_WindowFlags.SHOWN);
				renderer = sdl.renderer.create (window,0,SDL_RendererFlags.ACCELERATED);
			}
		}
		else
		{
			assert(0, "TODO support non Linux Platforms\n");
		}
		update_loop ();
	}

	void update_loop ()
	{
		while (running)
		{
			synchronized (lock)
			{
				renderer.clear;
				renderer.present;
				renderer.setColor(0,0,0);
				Thread.sleep(delay);
			}
		}
	}
}