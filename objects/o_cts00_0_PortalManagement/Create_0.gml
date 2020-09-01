/// @description Check Already Played & Init
m_initialized = false;

// Set constants
kFallHeight = 280;

// Create the waterfall portal
{	// Todo: save this with the water
	var doodad = instance_create_depth(x, y, 0, o_fxRift);
		doodad.z = 32;
	//	doodad.z_height = y - (getPlayer().y - kFallHeight) + 16;
		doodad.z_height = 536 - (637 - kFallHeight) + 16;
	with (doodad) {
		depthUpdate();
		depth += 8;
	}
}

// Mark as ready
m_initialized = true;