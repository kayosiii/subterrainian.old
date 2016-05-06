module sdl.c;
import sdl.defs;

@trusted extern (C):

int SDL_Init(uint flags);
int SDL_InitSubSystem(uint flags);
void SDL_QuitSubSystem(uint flags);
uint SDL_WasInit(uint flags);
void SDL_Quit();

SDL_Window * SDL_CreateWindow(const char *title, int x, int y, int w, int h, uint flags);
void SDL_DestroyWindow(SDL_Window * window);

SDL_Renderer * SDL_CreateRenderer(SDL_Window * window, int index, uint flags);
void SDL_DestroyRenderer(SDL_Renderer * renderer);
SDL_Texture * SDL_CreateTextureFromSurface(SDL_Renderer * renderer, SDL_Surface * surface);
SDL_Texture * SDL_CreateTexture(SDL_Renderer * renderer, uint format, int access, int w, int h);
int SDL_RenderClear(SDL_Renderer * renderer);
void SDL_RenderPresent(SDL_Renderer * renderer);
int SDL_SetRenderDrawColor(SDL_Renderer * renderer, ubyte r, ubyte g, ubyte b, ubyte a);
int SDL_SetRenderDrawBlendMode(SDL_Renderer * renderer, SDL_BlendMode blendMode);
int SDL_RenderDrawLine(SDL_Renderer * renderer, int x1, int y1, int x2, int y2);
int SDL_RenderDrawLines(SDL_Renderer * renderer, const SDL_Point * points, int count);
int SDL_RenderDrawRect(SDL_Renderer * renderer, const SDL_Rect * rect);
int SDL_RenderFillRect(SDL_Renderer * renderer, const SDL_Rect * rect);
int SDL_RenderDrawRects(SDL_Renderer * renderer, const SDL_Rect* rects, int count);
int SDL_RenderFillRects(SDL_Renderer * renderer, const SDL_Rect* rects, int count);

int TTF_Init();
TTF_Font * TTF_OpenFont(const char *file, int ptsize);
void TTF_CloseFont(TTF_Font *font);
void TTF_Quit();

int TTF_SizeText(TTF_Font *font, const char *text, int *w, int *h);
SDL_Surface * TTF_RenderText_Shaded(TTF_Font *font, const char *text, SDL_Color fg, SDL_Color bg);

int SDL_WaitEvent(SDL_Event * event);

