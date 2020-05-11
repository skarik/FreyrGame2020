var buffer = argument0;

if (!exists(kQuestManager))
{
	show_error("invalid quest state", true);
}

var off_preheader = buffer_tell(buffer);
var header = array_create(4);
for (var i = 0; i < 4; ++i)
	header[i] = buffer_read(buffer, buffer_u8);
if (header[0] == ord("E")
	&& header[1] == ord("M")
	&& header[2] == ord("I")
	&& header[3] == 0)
{
	debugOut("Savefile: Found EMI chunk");
}
else
{
	debugOut("Savefile: No EMI chunk");
	buffer_seek(buffer, buffer_seek_start, off_preheader);
	return;
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