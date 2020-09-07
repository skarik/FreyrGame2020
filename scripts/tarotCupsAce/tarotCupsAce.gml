/// @param data id
/// @param flipped
function tarotCupsAce(argument0, argument1) {

	var flipped = argument1;
	switch (argument0)
	{
	case kTarotData_AquireThought:
		if (!flipped)
			return "You feel quite personable today.";
		else
			return "You feel particularly inquisitive of people.";
	
	}

	return undefined;


}
