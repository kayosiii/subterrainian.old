module sdl.event;

public import sdl.defs : 
SDL_EventType, SDL_Scancode, SDL_Keycode, SDL_Keymod, 
	SDL_Keysym, SDL_CommonEvent, SDL_Event, SDL_KeyboardEvent, 
	SDL_WindowEvent, SDL_TextEditingEvent, SDL_TextInputEvent,
	SDL_MouseMotionEvent, SDL_MouseButtonEvent, SDL_MouseWheelEvent,
	SDL_Joystick, SDL_JoystickGUID, SDL_JoystickID, SDL_TouchID,
	SDL_FingerID, SDL_Finger, SDL_GestureID, SDL_JoyAxisEvent,
	SDL_JoyBallEvent, SDL_JoyHatEvent, SDL_JoyButtonEvent, SDL_JoyDeviceEvent,
	SDL_ControllerAxisEvent, SDL_ControllerButtonEvent, SDL_ControllerDeviceEvent,
	SDL_TouchFingerEvent, SDL_MultiGestureEvent, SDL_DollarGestureEvent,
	SDL_QuitEvent, SDL_OSEvent, SDL_UserEvent, SDL_SysWMEvent;

import sdl.c : SDL_WaitEvent;

pragma(inline):

bool wait (ref SDL_Event event) { return cast(bool) SDL_WaitEvent(&event); }