function gameLoad() {
#macro kSavestateErrorMsg_Start "Invalid save file: "
#macro kSavestateErrorMsg_InvalidHeader "The header loaded in was incorrect."
#macro kSavestateErrorMsg_BadPlayer "Invalid player object listed."

	var kSaveFile = "Freyr.pl";

	if (!file_exists(kSaveFile))
	{
	    return false;
	}
	// Load buffer from file
	var buf = buffer_load(kSaveFile);

	// Read in the header & version first
	var version = savestateCheckBufferHeader(buf, kSavestateHeader_TopLevel);
	if (version == 0)
	{
		show_error(kSavestateErrorMsg_Start + kSavestateErrorMsg_InvalidHeader, true);
		return false;
	}

	var pl;
	var target_room;

	while (buffer_tell(buf) < buffer_get_size(buf))
	{
		// Read in the header & the version and check what to load next:
		var next_header = savestatePeekBufferHeader(buf);
		var next_version = savestatePeekBufferHeaderVersion(buf);

		if (next_header == kSavestateHeader_PlayerInfo)
		{
			savestateCheckBufferHeader(buf, kSavestateHeader_PlayerInfo);
		
			// Create the player
			if (!iexists(o_PlayerTest)) inew(o_PlayerTest);
		
			// Read in the current player state:
			var pl_object_name = buffer_read(buf, buffer_string);
			pl = object_get_index(pl_object_name);
			if (pl == 0)
			{
				show_error(kSavestateErrorMsg_Start + kSavestateErrorMsg_BadPlayer, true);
				idelete(o_PlayerTest);
				return false;
			}
			else
			{   // Set the new player as the player
				if (!iexists(pl)) inew(pl); // I guess???
				pl.m_isPlayer = true; 
			}
		
			target_room		= room_get_index(buffer_read(buf, buffer_string));
			pl.x            = buffer_read(buf, buffer_u32);
			pl.y            = buffer_read(buf, buffer_u32);
		
			pl.m_checkpoint_valid = buffer_read(buf, buffer_u32);
			pl.m_checkpoint_room = room_get_index(buffer_read(buf, buffer_string));
			pl.m_checkpoint_x = buffer_read(buf, buffer_u32);
			pl.m_checkpoint_y = buffer_read(buf, buffer_u32);
		}
		else if (next_header == kSavestateHeader_Inventory)
		{
			inventoryLoad(buf);
		}
		else if (next_header == kSavestateHeader_PlayerStats)
		{
			pstatsLoad(buf);
		}
		else if (next_header == kSavestateHeader_World)
		{
			savestateCheckBufferHeader(buf, kSavestateHeader_World);
		
			if (!iexists(o_dayNightCycle))
			{
				inew(o_dayNightCycle);
			}
			o_dayNightCycle.m_timeOfDay	= buffer_read(buf, buffer_f64);
			o_dayNightCycle.m_day		= buffer_read(buf, buffer_f64);
		}
		else if (next_header == kSavestateHeader_Quests)
		{
			questLoad(buf);
		}
		else if (next_header == kSavestateHeader_InstFlags)
		{
			iflagLoad(buf);
		}
		else if (next_header == kSavestateHeader_EnemyInfo)
		{
			enemyInfoLoad(buf);
		}
		else if (next_header == kSavestateHeader_Checkpoints)
		{
			checkpointInfoLoad(buf);
		}
	}

	// Free resources
	buffer_delete(buf);

	// Move all player objects to the main object
	if (pl.m_checkpoint_valid)
	{
		pl.x = pl.m_checkpoint_x;
		pl.y = pl.m_checkpoint_y;
		target_room = pl.m_checkpoint_room;
	}
	with (o_PlayerTest)
	{
	    x = pl.x;
	    y = pl.y;
	}

	// Now go to the target room
	global._transition_source = null;
	transition_to(target_room);

	// Update the checkpoint state
	playerCheckpointSave(pl.x, pl.y, target_room);

	// Return a successful load
	return true;


}
