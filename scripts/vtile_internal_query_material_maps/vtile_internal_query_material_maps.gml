/// @desc DO_NOT_CALL
/// This function should not be called directly.
if (!global.material_layers_ready)
{
	var all_layers = layer_get_all();

	global.material_layers = [];
	for (var i = 0; i < array_length_1d(all_layers); ++i)
	{
		var tilemap = layer_tilemap_get_id(all_layers[i]);
		if (!layer_tilemap_exists(all_layers[i], tilemap))
			continue;
		
		var tileset = tilemap_get_tileset(tilemap);
		if (tileset == tilesetMaterial)
		{
			global.material_layers[array_length_1d(global.material_layers)] = tilemap;
		
			debugOut("Found material map \"" + layer_get_name(all_layers[i]) + "\"");
		
			layer_set_visible(all_layers[i], false);
		}
	}
	
	global.material_tile_layers = [];
	for (var i = 0; i < array_length_1d(all_layers); ++i)
	{
		var tilemap = layer_tilemap_get_id(all_layers[i]);
		if (!layer_tilemap_exists(all_layers[i], tilemap))
			continue;
		
		var tileset = tilemap_get_tileset(tilemap);
		if (tileset != tilesetCollision && tileset != tilesetMaterial && tileset != tileset0_Water)
		{
			global.material_tile_layers[array_length_1d(global.material_tile_layers)] = tilemap;
		}
	}
	
	global.material_layers_ready = true;
}
