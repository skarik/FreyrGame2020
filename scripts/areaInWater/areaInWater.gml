
var check_x = argument0;
var check_y = argument1;

return exists(collision_point(check_x, check_y + 6, ob_areaWater, true, true))
	&& exists(collision_point(check_x - 5, check_y + 6, ob_areaWater, true, true))
	&& exists(collision_point(check_x + 5, check_y + 6, ob_areaWater, true, true))
	&& exists(collision_point(check_x, check_y + 6 - 4, ob_areaWater, true, true))
	&& exists(collision_point(check_x, check_y + 6 + 4, ob_areaWater, true, true));