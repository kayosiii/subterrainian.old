module input;
import sdl.event;

void start()
{
	running = true;
	run_thread();
}

private:

void run_thread()
{
	SDL_Event sdl_event;

	while (running)
	{
		if (sdl_event.wait)
		{
			switch (sdl_event.type) with (SDL_EventType)
			{
				case QUIT:
					running = false;
					break;
				case KEYDOWN:
					switch (sdl_event.key.keysym.scancode) with (SDL_Scancode)
					{
						case RETURN:
						case ESCAPE:
							running = false;
							break;
						default: break;
					}
					break;
				default:
					break;
			}
		}
	}
}

__gshared bool running;