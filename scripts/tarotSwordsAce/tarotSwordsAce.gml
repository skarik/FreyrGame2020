/// @param data id
/// @param flipped
function tarotSwordsAce(argument0, argument1) {

	var flipped = argument1;
	switch (argument0)
	{
	case kTarotData_AquireThought:
		if (!flipped)
			return "Your mind feels especially sharp.";
		else
			return "Your mind feels slightly clouded today.";
	
	}

	return undefined;


}
