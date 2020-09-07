/// @function enemyInfoInitialize()
/// @desc Sets up the quest manager for the enemy map
function enemyInfoInitialize() {

#macro kEnemyInfoLiveState_Alive	0
#macro kEnemyInfoLiveState_Dead		1

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
	enemy_live_map = ds_map_create(); // are the enemies alive this run?
	enemy_info_map = ds_map_create(); // enemy KO & death count for respawning

	// set persistence
	persistent = true;

	// initialized quest system
	debugOut("initialized enemy state map");


}
