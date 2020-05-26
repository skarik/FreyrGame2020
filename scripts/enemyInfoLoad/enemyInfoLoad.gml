var buffer = argument0;

if (!exists(kQuestManager))
{
	show_error("invalid quest state", true);
}

if (!savestateCheckBufferHeader(buffer, kSavestateHeader_EnemyInfo))
{
	return;
}

with (kQuestManager)
{
	var live_count = buffer_read(buffer, buffer_u32);
	for (var i = 0; i < live_count; ++i)
	{
		// read map id
		var key_id = buffer_read(buffer, buffer_u64);
		
		// read the data
		var live = buffer_read(buffer, buffer_u16);
		
		// save the data & continue
		enemy_live_map[?key_id] = live;
	}
	
	var key_count = buffer_read(buffer, buffer_u32);
	for (var i = 0; i < key_count; ++i)
	{
		// read map id
		var key_id = buffer_read(buffer, buffer_u64);
		
		// read the data
		var info = array_create(3);
		info[0] = buffer_read(buffer, buffer_s32);
		info[1] = buffer_read(buffer, buffer_s32);
		info[2] = buffer_read(buffer, buffer_s32);
		
		// save the data & continue 
		enemy_info_map[?key_id] = info;
	}
}