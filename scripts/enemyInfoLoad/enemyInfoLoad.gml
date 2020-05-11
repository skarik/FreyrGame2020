var buffer = argument0;

if (!exists(kQuestManager))
{
	show_error("invalid quest state", true);
}

var header = buffer_read(buffer, buffer_string);
if (header != "EMI")
{
	show_error("corrupted save file?", true);
}

with (kQuestManager)
{
	var key_count = buffer_read(buffer, buffer_u32);
	
	for (var i = 0; i < key_count; ++i)
	{
		// read map id
		key_id = buffer_read(buffer, buffer_u64);
		
		// read the data
		var info = array_create(3);
		info[0] = buffer_read(buffer, buffer_s32);
		info[1] = buffer_read(buffer, buffer_s32);
		info[2] = buffer_read(buffer, buffer_s32);
		
		// save the data & continue 
		enemy_info_map[?key_id] = info;
	}
}