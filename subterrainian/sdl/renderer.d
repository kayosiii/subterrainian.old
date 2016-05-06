module sdl.renderer;

import sdl.c;

public import sdl.defs : SDL_Window, SDL_Renderer, SDL_RendererFlags, 
	SDL_Surface, SDL_Texture, SDL_TextureAccess, SDL_PixelFormat,
	SDL_BlendMode, SDL_Color, SDL_Rect, SDL_Point;

alias SDL_Renderer Renderer;

pragma(inline):
alias create = SDL_CreateRenderer;
alias destroy = SDL_DestroyRenderer;
bool setFullscreen (SDL_Renderer * renderer, bool fullscreen)
{
	return false;
}


bool renderCopy(SDL_Renderer * renderer, SDL_Texture * texture, SDL_Rect * sr, SDL_Rect * dr) 
{ return ! cast(bool) renderCopy(renderer,texture,sr,dr); }
alias clear = SDL_RenderClear;
alias present = SDL_RenderPresent;
alias createTexture = SDL_CreateTexture;
alias createTextureFromSurface = SDL_CreateTextureFromSurface;

bool setAlphaBlending(SDL_Renderer * renderer, bool blend)
{
	if (blend) return ! cast(bool) SDL_SetRenderDrawBlendMode(renderer, SDL_BlendMode.blend);
	return ! cast(bool) SDL_SetRenderDrawBlendMode(renderer, SDL_BlendMode.none);
}

bool setColor(SDL_Renderer * renderer, ubyte r, ubyte g, ubyte b, ubyte a = 255) { return ! cast(bool) SDL_SetRenderDrawColor(renderer,r,g,b,a); }
bool setColor(SDL_Renderer * renderer, SDL_Color col) { return ! cast(bool) SDL_SetRenderDrawColor(renderer,col.r,col.g,col.b,col.a); }

bool filledRectangle(SDL_Renderer * renderer, ref SDL_Rect rect)
{ return ! cast(bool) SDL_RenderFillRect(renderer,&rect); }
bool filledRectangle(SDL_Renderer * renderer, SDL_Rect * rect)
{ return ! cast(bool) SDL_RenderFillRect(renderer,rect); }
bool filledRectangle(SDL_Renderer * renderer, SDL_Point p0, SDL_Point p1)
{
	SDL_Rect r = {p0.x,p0.y,p1.x-p0.x,p1.y-p1.y};
	return ! cast(bool) SDL_RenderFillRect(renderer, &r); 
}

bool rectangle(SDL_Renderer * renderer, ref SDL_Rect rect)
{
	return ! cast(bool) SDL_RenderDrawRect(renderer, &rect);
}
bool rectangle(SDL_Renderer * renderer, SDL_Rect * rect)
{
	return ! cast(bool) SDL_RenderDrawRect(renderer, rect);
}
bool rectangle(SDL_Renderer * renderer, SDL_Point p0, SDL_Point p1)
{
	SDL_Rect r = {p0.x,p0.y,p1.x-p0.x,p1.y-p0.y};
	return ! cast(bool) SDL_RenderDrawRect(renderer,&r);
}

bool horizontalLine(SDL_Renderer * renderer, SDL_Point pos, uint length)
{
	return ! cast(bool) SDL_RenderDrawLine(renderer,pos.x,pos.y,pos.x+length,pos.y);
}
bool verticalLine(SDL_Renderer * renderer, SDL_Point pos, uint length)
{
	return ! cast(bool) SDL_RenderDrawLine(renderer,pos.x,pos.y,pos.x,pos.y+length);
}