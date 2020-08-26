/// @description AI On Alert

// Inherit the parent event
event_inherited();

if (array_length_1d(m_colliders) == 0)
{
	// Do animation and bring up the colliders
	
	// Find nearest ai walls
	var wallList = ds_list_create();
	var wallListCount = collision_circle_list(x, y, 300, o_aiWallHint, false, true, wallList, false);
	for (var i = 0; i < wallListCount; ++i)
	{
		var hint = wallList[|i];
		
		var newWall = inew(o_livelyRockWall);
			newWall.x = hint.x;
			newWall.y = hint.y;
			newWall.image_xscale = hint.image_xscale;
			newWall.image_yscale = hint.image_yscale;
			newWall.image_angle = hint.image_angle;
			
		m_colliders[array_length_1d(m_colliders)] = newWall;
	}
	ds_list_destroy(wallList);
}