function doodadSetElevation(argument0) {
	var doodad = argument0;

	var kBlock = 16;
	var kMaskSize = 32;

	var make_elevation = false;	// Are we going to make elevation for this doodad?
	var walkable_z = 4;			// Elevation up from the floor of the doodad
	var walkable_y = -4 - 5;	// Y position of the walkable
	var walkable_x = 0;			// X position of the walkable
	var walkable_width = 7;		// X width of the walkable
	var walkable_height = 5;	// Y height of the walkable

	switch (doodad.sprite_index)
	{
		case s_propMithraBuilding0:
			make_elevation = true;
			walkable_x = 0;
			walkable_y = -4 - 5;
			walkable_z = 4;
			walkable_width = 7;
			walkable_height = 4.5;
			break;
		case s_propMithraBuilding1:
			make_elevation = true;
			walkable_x = 0;
			walkable_y = -4 - 5;
			walkable_z = 4;
			walkable_width = 14;
			walkable_height = 4.5;
			break;
		
		case s_propMithraBuildingExt0:
			make_elevation = true;
			walkable_x = 0;
			walkable_y = -3 - 3;
			walkable_z = 3;
			walkable_width = 3;
			walkable_height = 3;
			break;
		case s_propMithraBuildingExt1:
			make_elevation = true;
			walkable_x = 0;
			walkable_y = -3 - 3;
			walkable_z = 3;
			walkable_width = 4;
			walkable_height = 3;
			break;
		
		case s_propMithraBuilding2:
			make_elevation = true;
			walkable_x = 0;
			walkable_y = -3 - 3;
			walkable_z = 3;
			walkable_width = 5;
			walkable_height = 3;
			break;
		
		case s_propMithraBuilding2b:
			make_elevation = true;
			walkable_x = 0;
			walkable_y = -3 - 4;
			walkable_z = 3;
			walkable_width = 7;
			walkable_height = 3.5;
			break;
		
		case s_propMithraBuilding3:
			make_elevation = true;
			walkable_x = 0;
			walkable_y = -2 - 3;
			walkable_z = 2;
			walkable_width = 3;
			walkable_height = 3;
			break;
	}

	if (make_elevation)
	{
		var elevation = instance_create_depth(doodad.x, doodad.y, -13, ob_elevationArea);
			elevation.sprite_index = sceT_32x32;
			elevation.x += -doodad.sprite_xoffset + doodad.image_xscale * (walkable_x * kBlock);
			elevation.y += doodad.image_yscale * (walkable_y * kBlock);
			elevation.image_xscale = doodad.image_xscale * (walkable_width * kBlock) / kMaskSize;
			elevation.image_yscale = doodad.image_yscale * (walkable_height * kBlock) / kMaskSize;
			elevation.z = doodad.z + (walkable_z * kBlock);
			elevation.ignore_below = false;
		doodad.elevation = elevation;
	}


}
