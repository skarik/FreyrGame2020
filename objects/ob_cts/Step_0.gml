
// Run cutscene
if (cutsceneUpdate())
{
	if (cutsceneHasSignal())
	{
		var signalString = cutsceneGetSignal();
		cutsceneSignalConsume();
		
		if (string_pos("GoTo", signalString) != 0)
		{
			var signalStringSplit = string_split(signalString, " \n\t", true);
			if (array_length_1d(signalStringSplit) > 1)
			{
				var nextRoom = room_get_index(signalStringSplit[1]);
				if (room_exists(nextRoom))
				{
					transition_to(nextRoom);
				}
			}
		}
		else if (string_pos("ShowCredits", signalString) != 0)
		{
			inew_unique(o_ctsThankYouForPlaying);
		}
	}
}