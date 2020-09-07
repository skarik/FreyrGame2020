/// @param data id
/// @param flipped
function tarotStavesAce(argument0, argument1) {

	var flipped = argument1;
	switch (argument0)
	{
	case kTarotData_AquireThought:
		if (!flipped)
			return "You feel light beneath your feet.";
		else
			return "You feel momentarily lost.";
	
	}

	return undefined;


}
