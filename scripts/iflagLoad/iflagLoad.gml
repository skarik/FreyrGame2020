var buffer = argument0;

if (!iexists(kQuestManager))
{
	show_error("invalid quest state", true);
}

if (!savestateCheckBufferHeader(buffer, kSavestateHeader_InstFlags))
{
	return;
}

// format
//	u32 count
//	struct[count]
//	{
//		u64 key
//		s32 flag
//	}

with (kQuestManager)
{
	var flag_count = buffer_read(buffer, buffer_u32);
	
	for (var i = 0; i < flag_count; ++i)
	{
		var flag_key = buffer_read(buffer, buffer_u64);
		var flag_value = buffer_read(buffer, buffer_s32);
		
		iflag_state[?flag_key] = flag_value;
	}
}