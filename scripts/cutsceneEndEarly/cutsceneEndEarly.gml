/// @description Cutscene_EndEarly()
function cutsceneEndEarly() {
	// Ends a cutscene early


	// Set to max entry
	cts_entry_current = cts_entry_count;
	// Remove talkers
	with ( ob_CtsTalker )
	{
	    input_fadeout = true;
	}



}
