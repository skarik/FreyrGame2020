if (!global.water_layers_ready)
{
	var all_layers = layer_get_all();

	global.water_layers = [];
	for (var i = 0; i < array_length_1d(all_layers); ++i)
	{
		var tilemap = layer_tilemap_get_id(all_layers[i]);
		if (!layer_tilemap_exists(all_layers[i], tilemap))
			continue;
			
		var do_collision = string_pos("colli", layer_get_name(all_layers[i])) != 0;
		if (!do_collision)
			continue;
		
		var tileset_id = tilemap_get_tileset(tilemap);
		if (tileset_id == tileset0_Water /* || tileset_id == tileset1_Water*/)
		{
			global.water_layers[array_length_1d(global.water_layers)] = tilemap;
		
			debugOut("Found water collision map \"" + layer_get_name(all_layers[i]) + "\"");
		
			layer_set_visible(all_layers[i], false);
		}
	}
	
	/*if (array_length_1d(global.water_layers) >= 1 && !exists(o_waterTileRenderer))
	{
		new(o_waterTileRenderer);
	}*/
}