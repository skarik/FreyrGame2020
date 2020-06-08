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
	checkpoint_list[2] = [rm_fools_march, "default", "Fool's March Central"];
	checkpoint_list[3] = [rm_fools_march, "south", "Fool's March South"];
	checkpoint_list[4] = [rm_mithra, "default", "Mithra West"];
	checkpoint_list[5] = [rm_fools_tower, "default", "Fool's Tower"];
}