/// @description areaInWater(x, y, z)
/// @param x
/// @param y
/// @param z

var check_x = argument0;
var check_y = argument1;
var check_z = argument2;

//var yoffset = 6;
var yoffset = 0;

var water_height = area3_internal_tilemap_get_water_height(check_x, check_y + yoffset);
if (water_height != kElevationInvalid) // Actually have water elevation?
{
	// Is 8 pixels below feet still over the water?
	if (check_z - 8 > water_height)
	{
		// Not in water
		return false;
	}
}

return 
	(area3_internal_tilemap_get_water(check_x, check_y + yoffset)
			|| iexists(collision_point(check_x, check_y + yoffset, ob_areaWater, true, true)))
	&&
	(area3_internal_tilemap_get_water(check_x - 5, check_y + yoffset)
			|| iexists(collision_point(check_x - 5, check_y + yoffset, ob_areaWater, true, true)))
	&&
	(area3_internal_tilemap_get_water(check_x + 5, check_y + yoffset)
			|| iexists(collision_point(check_x + 5, check_y + yoffset, ob_areaWater, true, true)))
	&&
	(area3_internal_tilemap_get_water(check_x, check_y + yoffset - 4)
			|| iexists(collision_point(check_x, check_y + yoffset - 4, ob_areaWater, true, true)))
	&&
	(area3_internal_tilemap_get_water(check_x, check_y + yoffset + 4)
			|| iexists(collision_point(check_x, check_y + yoffset + 4, ob_areaWater, true, true)));