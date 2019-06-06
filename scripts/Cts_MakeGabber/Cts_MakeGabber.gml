/// Cts_MakeGabber(character, name, string)
// Escape sequences start with $. See engine docs for more info.

// Find existing gabber:
var existing_gabber = null;
if (instance_number(o_CtsGabberBox) == 1)
{
	existing_gabber = instance_find(o_CtsGabberBox, 0);
	
	// Is it the same person talking?
	if (existing_gabber.input_actor != argument0
		|| existing_gabber.input_name != argument1
		|| existing_gabber.input_actor == o_PlayerImp)
	{
		existing_gabber = null;
	}
}

var talker = null;
if (existing_gabber != null && exists(existing_gabber))
{
	talker = existing_gabber;
	Cts_GabberReset(talker);
	
	// After reset, set new text
	talker.input_text = argument2;
}
else
{
	talker = new(o_CtsGabberBox);
	talker.input_actor = argument0;
	talker.input_name = argument1;
	talker.input_text = argument2;
}
    
with (talker)
{
    Cts_ParseDialogue();
    //Cts_GenerateWidths();
}

return talker;