/// @function ctsMakeTalker(character, portrait_index, name, string)
/// @description Makes an important talkbox. Escape sequences start with $. See engine docs for more info.
/// @param character
/// @param portrait_index
/// @param name
/// @param string
function ctsMakeTalker(argument0, argument1, argument2, argument3) {

	// Find existing gabber:
	var existing_gabber = null;
	if (instance_number(o_CtsTalkerBox) == 1)
	{
		existing_gabber = instance_find(o_CtsTalkerBox, 0);
	
		// Is it the same person talking?
		if (existing_gabber.input_actor != argument0
			|| existing_gabber.input_portrait != argument1
			|| existing_gabber.input_name != argument2
			|| existing_gabber.input_actor == o_PlayerImp)
		{
			existing_gabber = null;
		}
	}

	var talker = null;
	if (existing_gabber != null && iexists(existing_gabber))
	{
		talker = existing_gabber;
		ctsGabberReset(talker);
	
		// After reset, set new text
		talker.input_text = argument3;
	}
	else
	{
		talker = inew(o_CtsTalkerBox);
		talker.input_actor = argument0;
		talker.input_portrait = argument1;
		talker.input_name = argument2;
		talker.input_text = argument3;
	}
    
	with (talker)
	{
	    ctsParseDialogue();
	    //Cts_GenerateWidths();
	}

	return talker;


}
