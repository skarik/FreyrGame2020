/// @function checkpointInfoInitialize()
/// @desc Sets up the quest manager for the enemy map

// [0] : room (id)
// [1] : id (string)
// [2] : desc (string)

// check is valid quest manager
var other_id = id;
with (kQuestManager)
{
	if (other_id != id)
	{
		show_error("invalid quest manager", true);
	}
}

checkpoint_list = array_create(0);

// set persistence
persistent = true;

// initialized quest system
debugOut("initialized checkpoint list");