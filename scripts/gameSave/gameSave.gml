#macro kSavestateHeader_TopLevel	"SAVE"
#macro kSavestateHeader_PlayerInfo	"PLYR"
#macro kSavestateHeader_Inventory	"INV"
#macro kSavestateHeader_PlayerStats	"STAT"
#macro kSavestateHeader_World		"WRLD"
#macro kSavestateHeader_Quests		"QSTS"
#macro kSavestateHeader_EnemyInfo	"EMI"
#macro kSavestateHeader_Checkpoints	"CHKS"
#macro kSavestateVersion			0x00000003

// Save any farms before the player
with (o_farmAreaManager)
{
	savestateFarmSave();
}

var kSaveFile = "Freyr.pl";

var buf = buffer_create(4096, buffer_grow, 1);
var pl = getPlayer();

// Write out the header & version first
savestateWriteBufferHeader(buf, kSavestateHeader_TopLevel, kSavestateVersion);

// Write out the current player information (type, room, position)
savestateWriteBufferHeader(buf, kSavestateHeader_PlayerInfo, kSavestateVersion);
{
	if (!iexists(pl))
	{
	    buffer_write(buf, buffer_u32, 0);
	    exit;
	}

	buffer_write(buf, buffer_string, object_get_name(pl.object_index));
	buffer_write(buf, buffer_string, room_get_name(room));
	buffer_write(buf, buffer_u32, pl.x);
	buffer_write(buf, buffer_u32, pl.y);
	
	buffer_write(buf, buffer_u32, pl.m_checkpoint_valid);
	buffer_write(buf, buffer_string, room_get_name(pl.m_checkpoint_room));
	buffer_write(buf, buffer_u32, pl.m_checkpoint_x);
	buffer_write(buf, buffer_u32, pl.m_checkpoint_y);
}

// write inventory
inventorySave(buf);

// write stats
pstatsSave(buf);

// Current world-state
savestateWriteBufferHeader(buf, kSavestateHeader_World, kSavestateVersion);
{
	buffer_write(buf, buffer_f64, o_dayNightCycle.m_timeOfDay);
	buffer_write(buf, buffer_f64, o_dayNightCycle.m_day);
}

// Write out Game's flags
questSave(buf);

// Write out enemy flags
enemyInfoSave(buf);

// Write out checkpoint state
checkpointInfoSave(buf);

// Save buffer to file
buffer_save(buf, kSaveFile);

// Free resources
buffer_delete(buf);

