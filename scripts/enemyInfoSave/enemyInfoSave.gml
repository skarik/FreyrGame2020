var buffer = argument0;

if (!iexists(kQuestManager))
{
	show_error("invalid quest state", true);
}

savestateWriteBufferHeader(buffer, kSavestateHeader_EnemyInfo, kSavestateVersion);

with (kQuestManager)
{
	// enemy_info_map updated as game runs
	
	var live_count = ds_map_size(enemy_live_map);
	buffer_write(buffer, buffer_u32, live_count);
	
	var current_key = ds_map_find_first(enemy_live_map);
	for (var i = 0; i < live_count; ++i)
	{
		// write the map's id
		buffer_write(buffer, buffer_u64, current_key);
		
		// write the data
		var enemy_live = enemy_live_map[?current_key];
		buffer_write(buffer, buffer_u16, enemy_live);
		
		// seek to the next key
		current_key = ds_map_find_next(enemy_live_map, current_key);
	}
	
	var key_count = ds_map_size(enemy_info_map);
	buffer_write(buffer, buffer_u32, key_count);
	
	var current_key = ds_map_find_first(enemy_info_map);
	for (var i = 0; i < key_count; ++i)
	{
		// write the map's id
		buffer_write(buffer, buffer_u64, current_key);
		
		// write the data:
		var enemy_info = enemy_info_map[?current_key];
		buffer_write(buffer, buffer_s32, enemy_info[0]);
		buffer_write(buffer, buffer_s32, enemy_info[1]);
		buffer_write(buffer, buffer_s32, enemy_info[2]);
		
		// seek to the next key
		current_key = ds_map_find_next(enemy_info_map, current_key);
	}
}