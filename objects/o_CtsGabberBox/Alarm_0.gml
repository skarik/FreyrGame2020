/// @description Hide other talkers

// Only fade out others if we're not special side-stuff
if (!input_minimal)
{
	with ( ob_CtsTalker )
	{
		if (object_index == o_CtsGabberBox)
		{
			// Detect organic/minimal
			if (!input_minimal)
				input_fadeout = true;
		}
		else
		{	// Fade out everything else regardless
			input_fadeout = true;
		}
	}
}