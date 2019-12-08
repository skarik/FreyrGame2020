/// @description slide_down_cliff(x, y)
/// @param x
/// @param y

var ob_x = argument0;
var ob_y = argument1;
var ob_z = argument2;

/*var results = ds_list_create();
var results_count = collision_point_list(ob_x, ob_y, ob_collider, true, true, results, false);
ds_list_destroy(results); //Don't really care about specific results.
*/
var on_collision = collision3_meeting(ob_x, ob_y, ob_z, true);
show_debug_message(string(on_collision));
if (on_collision == true)
{
	return 0.5; //return the distance to slide down
}

return 0.0; //Don't slide
