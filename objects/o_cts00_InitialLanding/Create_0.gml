/// @description Check Already Played & Init
m_initialized = false;

if (questGetValue(kQidIntroSequence) != 0)
{
	delete(this);
	exit;
}

// Set constants
kFallHeight = 280;

// Load the cutscene
cutsceneLoad("00_initialLanding.txt");
//questSetValue(kQidIntroSequence, 10);

// Create the waterfall portal
{	// Todo: save this with the water
	var doodad = instance_create_depth(x, y, 0, o_fxPortal);
		doodad.z = 32;
		doodad.z_height = y - (getPlayer().y - kFallHeight) + 16;
	with (doodad) {
		depthUpdate();
		depth += 8;
	}
}

// Mark as ready
m_initialized = true;