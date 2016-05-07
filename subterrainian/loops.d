module loops;

enum LoopState
{
	Stopped,
	Playing,
	Playing_Reversed,
	Recording
}
__gshared LoopState state;

import memory;
struct LoopRecorder
{
	RecordBlock * head;
	RecordBlock * current;
	sample_t[] filled;
	sample_t[] playback;

	this(RecordBlock * b)
	{
		head = b;
		current = head;
		filled = current.data[0..0];
		playback = filled[];
	}

	@property empty()
	{
		return (head == current) & (filled.length == 0);
	}
	@property front()
	{
		assert (playback.length > 0, "front -> ");
		return playback[0];
	}
	@property back()
	{
		return playback[$-1];
	}
	@process length()
	{
		auto n = 0;
		RecordBlock * tmp = head;
		while(tmp.next != null)
		{
			n += tmp.data.length;
			tmp = tmp.next;
		}
		n+=filled.length;
		return n;
	}
	void popFront()
	{		
		playback = playback[1..$];
		if (playback.length < 1) 
		{
			current = current.next;
			playback = (current.next == head) ? filled[] : current.data[];
		}
	}
	void popBack()
	{
		playback = playback[0..$-1];
		if (playback.length < 1)
		{
			current = current.prev;
			playback = (current.next == head) ? filled[] : current.data[];
		}
	}
	void setupPlayback( LoopState state )
	{
		RecordBlock *last = head;
		while (last.next != null) last = last.next;
		last.next = head;
		head.prev = last;

		switch (state) with (LoopState)
		{
			case Playing:
				playback = (head.next == null)? filled[] : head.data[];
				break;
			case Playing_Reversed:
				playback = filled[];
				break;
			default:
				break;
		}

		assert (playback.length > 0);
	}

	void put (sample_t[] input)
	{
		auto p = filled.length;
		auto l = p + input.length;
		if (l <= current.data.length)
		{
			filled = current.data[0..l];
			filled[p..$] = input[];
		}
		else 
		{
			auto r1 = current.data.length - p;
			auto r2 = input.length - r1;
			filled = current.data[];
			filled[p..$] = input[0..r1];
			RecordBlock * next = memory.getRecordBlock();
			current.next = next;
			next.prev = current;
			current = next;
			filled = current.data[0..r2];
			filled[] = input[r1..$];
		}
	}
}


__gshared LoopRecorder recorder;
import std.algorithm : copy;
import std.range : take;
alias copyTo = copy;

import mixer,types;
void process(nframes_t n)
{
	final switch(state) with (LoopState)
	{
		case Recording:
			recorder.put(mixer.inputs[0].channels[0].buffer[0..n]);
			break;
		case Playing:
			foreach(i; 0..n)
			{
				main.channels[0].buffer[i] = recorder.front;
				recorder.popFront();
			}
//			recorder.take(n).copyTo(mixer.main.channels[0].buffer[0..n]);
//			writeln(recorder.playback.length.to!string());
			break;
		case Playing_Reversed:
			foreach(i; 0..n)
			{
				main.channels[0].buffer[i] = recorder.back;
				recorder.popBack();
			}
			break;
		case Stopped:
			break;
	}
}

import std.stdio : writeln;
import std.conv : to;
void loop_clicked()
{
	if (recorder.empty == true) state = LoopState.Recording;
	else if (state != LoopState.Playing_Reversed) 
	{
		state = LoopState.Playing_Reversed;
		recorder.setupPlayback(state);
	}
	else state = LoopState.Stopped;
	writeln("loop state: ",to!string(state));
}

shared static this()
{
	recorder = LoopRecorder(memory.getRecordBlock());
}