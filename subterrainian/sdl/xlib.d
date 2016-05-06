module xlib;

private extern (C) int XInitThreads();
pragma(inline) bool initThreads() {  return cast(bool) XInitThreads(); } 
