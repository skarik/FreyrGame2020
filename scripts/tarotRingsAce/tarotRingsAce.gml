/// @param data id
/// @param flipped
function tarotRingsAce(argument0, argument1) {

	var flipped = argument1;
	switch (argument0)
	{
	case kTarotData_AquireThought:
		if (!flipped)
			return "Today feels like a lucky day for some junk.";
		else
			return "Today feels like you wont find any junk.";
	
	}

	return undefined;


}
