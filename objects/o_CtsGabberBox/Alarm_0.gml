/// @description Hide other talkers

var callee = this;

// Only fade out others if we're not special side-stuff
if (!input_minimal)
{
	with ( ob_CtsTalker )
	{
		// Skip the callee
		if (id == callee)
			continue;
			
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