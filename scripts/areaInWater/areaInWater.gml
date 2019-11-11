var check_x = argument0;
var check_y = argument1;

//var yoffset = 6;
var yoffset = 0;

return 
	(area3_internal_tilemap_get_water(check_x, check_y + yoffset)
			|| exists(collision_point(check_x, check_y + yoffset, ob_areaWater, true, true)))
	&&
	(area3_internal_tilemap_get_water(check_x - 5, check_y + yoffset)
			|| exists(collision_point(check_x - 5, check_y + yoffset, ob_areaWater, true, true)))
	&&
	(area3_internal_tilemap_get_water(check_x + 5, check_y + yoffset)
			|| exists(collision_point(check_x + 5, check_y + yoffset, ob_areaWater, true, true)))
	&&
	(area3_internal_tilemap_get_water(check_x, check_y + yoffset - 4)
			|| exists(collision_point(check_x, check_y + yoffset - 4, ob_areaWater, true, true)))
	&&
	(area3_internal_tilemap_get_water(check_x, check_y + yoffset + 4)
			|| exists(collision_point(check_x, check_y + yoffset + 4, ob_areaWater, true, true)));