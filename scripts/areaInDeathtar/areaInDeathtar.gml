/// @function areaInDeathtar(x, y, z)
/// @description Checks if the given position is in deathtar - with margin checking.
/// @param x
/// @param y
/// @param z
function areaInDeathtar(argument0, argument1, argument2) {

	var check_x = argument0;
	var check_y = argument1;
	var check_z = argument2;

	//var yoffset = 6;
	var yoffset = 0;

	var tar_height = col3_internal_tilemap_get_elevation(check_x, check_y + yoffset);
	if (tar_height != kElevationInvalid) // Actually have water elevation?
	{
		// Is 2 pixels below feet still over the water?
		if (check_z - 2 > tar_height)
		{
			// Not in water
			return false;
		}
	}

	return 
		(area3_internal_tilemap_get_deathtar(check_x, check_y + yoffset)
				|| iexists(collision_point(check_x, check_y + yoffset, ob_areaDeathtar, true, true)))
		&&
		(area3_internal_tilemap_get_deathtar(check_x - 5, check_y + yoffset)
				|| iexists(collision_point(check_x - 5, check_y + yoffset, ob_areaDeathtar, true, true)))
		&&
		(area3_internal_tilemap_get_deathtar(check_x + 5, check_y + yoffset)
				|| iexists(collision_point(check_x + 5, check_y + yoffset, ob_areaDeathtar, true, true)))
		&&
		(area3_internal_tilemap_get_deathtar(check_x, check_y + yoffset - 4)
				|| iexists(collision_point(check_x, check_y + yoffset - 4, ob_areaDeathtar, true, true)))
		&&
		(area3_internal_tilemap_get_deathtar(check_x, check_y + yoffset + 4)
				|| iexists(collision_point(check_x, check_y + yoffset + 4, ob_areaDeathtar, true, true)));


}
