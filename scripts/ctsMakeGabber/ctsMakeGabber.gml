/// @function ctsMakeGabber(character, name, string)
/// @description Makes a banterbox. Escape sequences start with $. See engine docs for more info.
/// @param character {Object}
/// @param name {String}
/// @param string {String}
/// --param (Optional) minimal {Bool}
function ctsMakeGabber(argument0, argument1, argument2) {

	// Find existing gabber:
	var existing_gabber = null;
	if (instance_number(o_CtsGabberBox) == 1)
	{
		existing_gabber = instance_find(o_CtsGabberBox, 0);
	
		// Is it the same person talking?
		if (existing_gabber.input_actor != argument0
			|| existing_gabber.input_name != argument1
			|| (existing_gabber.input_actor == o_PlayerImp && argument0 == o_PlayerImp)
			|| (existing_gabber.input_actor == o_PlayerImp && argument0 == null))
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
		talker.input_text = argument2;
	}
	else
	{
		talker = inew(o_CtsGabberBox);
		talker.input_actor = argument0;
		talker.input_name = argument1;
		talker.input_text = argument2;
	}
    
	with (talker)
	{
	    ctsParseDialogue();
	    //Cts_GenerateWidths();
	}

	return talker;


}
