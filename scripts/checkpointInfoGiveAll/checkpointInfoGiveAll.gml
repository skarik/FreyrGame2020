/// @function checkpointInfoGiveAllCheat()
/// @desc cheat, teleport to anywhere

with (kQuestManager)
{
	// checkpoint_list updated as game runs
	// [0] : room (id)
	// [1] : id (string)
	// [2] : desc (string)
	
	checkpoint_list[0] = [rm_oasis_farm, "default", "Oasis Farm"];
	checkpoint_list[1] = [rm_test_combat, "default", "Debug: Combat Test"];
}