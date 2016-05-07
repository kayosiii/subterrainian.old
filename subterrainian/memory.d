module memory;

import std.experimental.allocator.building_blocks.bitmapped_block : BitmappedBlock;
import std.experimental.allocator.building_blocks.allocator_list : AllocatorList;
import std.experimental.allocator.mmap_allocator : MmapAllocator;
import std.experimental.allocator.mallocator : Mallocator;
import std.experimental.allocator : make, makeArray, dispose, platformAlignment;
import types : sample_t;

enum record_block_size = 16_384;
enum num_record_blocks = 128;

alias RecordingMemList = AllocatorList!
(
	(n) => BitmappedBlock!(record_block_size,platformAlignment,MmapAllocator)(MmapAllocator.instance.allocate(record_block_size*num_record_blocks*sample_t.sizeof)),
	Mallocator
);
		
RecordingMemList rlist;

shared static this ()
{
}

import types;

struct RecordBlock
{
	RecordBlock * next;
	RecordBlock * prev;
	sample_t [record_block_size - ((RecordBlock*).sizeof*2)] data;
}

RecordBlock * getRecordBlock()
{
	return cast(RecordBlock*) rlist.allocate(RecordBlock.sizeof);
}
