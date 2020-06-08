var buffer = argument0;

if (!iexists(kQuestManager))
{
	show_error("invalid quest state", true);
}

if (!savestateCheckBufferHeader(buffer, kSavestateHeader_Checkpoints))
{
	return;
}

with (kQuestManager)
{
	// checkpoint_list updated as game runs
	// [0] : room (id)
	// [1] : id (string)
	// [2] : desc (string)
	
	var checkpoint_count = buffer_read(buffer, buffer_u32);
	checkpoint_list = array_create(checkpoint_count);
	
	for (var i = 0; i < checkpoint_count; ++i)
	{
		// write checkpoint room name
		var checkpoint_room_name = buffer_read(buffer, buffer_string);
		
		// write checkpoint id
		var checkpoint_name = buffer_read(buffer, buffer_string);
		
		// write checkpoint desc
		var checkpoint_desc = buffer_read(buffer, buffer_string);
		
		// add checkpoint to list
		checkpoint_list[i] = [room_get_index(checkpoint_room_name), checkpoint_name, checkpoint_desc];
	}
}