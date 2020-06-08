// @function checkpointOpenTeleportMenu()
// @desc Spawns a menu with all the unlocked teleports in the list.

var callee = id;

with (kQuestManager)
{
	// Ask for if we want to restart at last checkpoint or at the farm
	var gabber = inew(o_CtsChoiceBox);
		gabber.input_choice_count = 1 + array_length_1d(checkpoint_list);
		gabber.input_choice[0] = "Cancel";
		gabber.input_actor = callee;
		gabber.display_width = 120;
		gabber.display_blackbox_override = true;
		
	for (var i = 0; i < gabber.input_choice_count - 1; ++i)
	{
		var checkpoint_info = checkpoint_list[i];
		gabber.input_choice[i + 1] = checkpoint_info[2];
	}
}