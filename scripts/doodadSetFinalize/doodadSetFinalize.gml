function doodadSetFinalize(argument0) {
	var doodad = argument0;

	switch (doodad.sprite_index)
	{
		case s_propTProjector:
			doodad.z += 16;
			break;
	}


}
