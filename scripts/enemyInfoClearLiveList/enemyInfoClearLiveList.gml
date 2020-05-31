/// @function enemyInfoClearLiveList()
/// @desc Clears the live list so things can respawn when the spawners are triggered.

with (kQuestManager)
{
	ds_map_clear(enemy_live_map);
}