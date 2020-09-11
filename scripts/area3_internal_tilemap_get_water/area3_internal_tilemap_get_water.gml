/// @desc DO_NOT_CALL
/// This function should not be called directly.
function area3_internal_tilemap_get_water(argument0, argument1)
{
	var check_x = argument0;
	var check_y = argument1;

	var cel_x = int64(check_x) >> 4;
	var cel_y = int64(check_y) >> 4;
	
	var l_water_layers = global.water_layers;

	col3_internal_query_collision_maps();
	var layer_count = array_length_1d(l_water_layers);
	for (var i = 0; i < layer_count; ++i)
	{
		var tilemap = l_water_layers[i];
		var tile = tilemap_get(tilemap, cel_x, cel_y);
		var tile_id = tile & 0xFF;

		if (tile_id != 0)
			return true;
	}
	return false;
}
