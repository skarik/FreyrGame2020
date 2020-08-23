/// @desc DO_NOT_CALL
/// This function should not be called directly.
if (!global.collidable_layers_ready)
{
	var all_layers = layer_get_all();

	global.collidable_layers = [];
	for (var i = 0; i < array_length_1d(all_layers); ++i)
	{
		var tilemap = layer_tilemap_get_id(all_layers[i]);
		if (!layer_tilemap_exists(all_layers[i], tilemap))
			continue;
		
		var tileset = tilemap_get_tileset(tilemap);
		if (tileset == tilesetCollision)
		{
			global.collidable_layers[array_length_1d(global.collidable_layers)] = tilemap;
			global.collidable_offset_x[array_length_1d(global.collidable_offset_x)] = 0;
			global.collidable_offset_y[array_length_1d(global.collidable_offset_y)] = 0;
		
			debugOut("Found collision map \"" + layer_get_name(all_layers[i]) + "\"");
		
			layer_set_visible(all_layers[i], false);
		}
	}
	
	global.collidable_layers_ready = true;
}
