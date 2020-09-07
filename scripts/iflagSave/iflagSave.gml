function iflagSave(argument0) {
	var buffer = argument0;

	if (!iexists(kQuestManager))
	{
		show_error("invalid quest state", true);
	}

	savestateWriteBufferHeader(buffer, kSavestateHeader_InstFlags, kSavestateVersion);

	// format
	//	u32 count
	//	struct[count]
	//	{
	//		u64 key
	//		s32 flag
	//	}

	with (kQuestManager)
	{
		var flag_count = ds_map_size(iflag_state);
	
		buffer_write(buffer, buffer_u32, flag_count);
	
		var flag_key = ds_map_find_first(iflag_state);
		for (var i = 0; i < flag_count; ++i)
		{
			var flag_value = iflag_state[?flag_key];
		
			buffer_write(buffer, buffer_u64, flag_key);
			buffer_write(buffer, buffer_s32, flag_value);
		
			ds_map_find_next(iflag_state, flag_key);
		}
	}


}
