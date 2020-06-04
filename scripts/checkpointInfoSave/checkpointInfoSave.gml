var buffer = argument0;

if (!iexists(kQuestManager))
{
	show_error("invalid quest state", true);
}

savestateWriteBufferHeader(buffer, kSavestateHeader_Checkpoints, kSavestateVersion);

with (kQuestManager)
{
	// checkpoint_list updated as game runs
	// [0] : room (id)
	// [1] : id (string)
	// [2] : desc (string)
	
	var checkpoint_count = array_length_1d(checkpoint_list);
	buffer_write(buffer, buffer_u32, checkpoint_count);
	
	for (var i = 0; i < checkpoint_count; ++i)
	{
		var checkpoint_info = checkpoint_list[i];
		
		// write checkpoint room name
		buffer_write(buffer, buffer_string, room_get_name(checkpoint_info[0]));
		
		// write checkpoint id
		buffer_write(buffer, buffer_string, checkpoint_info[1]);
		
		// write checkpoint desc
		buffer_write(buffer, buffer_string, checkpoint_info[2]);
	}
}