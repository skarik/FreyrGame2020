// check is valid quest manager
var other_id = id;
with (kQuestManager)
{
	if (other_id != id)
	{
		show_error("invalid quest manager", true);
	}
}

// init info map
enemy_info_map = ds_map_create();

// set persistence
persistent = true;

// initialized quest system
debugOut("initialized enemy state map");