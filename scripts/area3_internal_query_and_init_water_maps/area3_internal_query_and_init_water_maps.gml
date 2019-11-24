if (!global.water_layers_ready)
{
	var all_layers = layer_get_all();

	global.water_layers = [];
	global.water_zposition = [];
	
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
			var new_water_layer_index = array_length_1d(global.water_layers);
			
			// Save new water map.
			global.water_layers[new_water_layer_index] = tilemap;
			global.water_zposition[new_water_layer_index] = 256;
		
			debugOut("Found water collision map \"" + layer_get_name(all_layers[i]) + "\"");
		
			// Set new water map as invisible...
			layer_set_visible(all_layers[i], false);
			
			// Find the first tile in it, and check the elevation at its position
			var first_water_tile = 0;
			var ix, iy;
			for (ix = 0; ix < tilemap_get_width(tilemap); ++ix)
			{
				for (iy = 0; iy < tilemap_get_height(tilemap); ++iy)
				{
					first_water_tile = tilemap_get(tilemap, ix, iy);
					if (first_water_tile != 0)
					{
						// Save elevation of this water map.
						var next_collision = col3_internal_tilemap_get_elevation(ix * 16, iy * 16);
						if (next_collision == kElevationInvalid)
						{
							// Invalid elevation sample? We keep searching.
							//first_water_tile = 0;
						}
						else
						{
							global.water_zposition[new_water_layer_index] = min(next_collision, global.water_zposition[new_water_layer_index]);
						}
					}
				}
				if (first_water_tile != 0)
						break;
			}
			
			debugOut("Water collision map height set to " + string(global.water_zposition[new_water_layer_index]));
		}
		// Onto next layer.
	}
	
	/*if (array_length_1d(global.water_layers) >= 1 && !exists(o_waterTileRenderer))
	{
		new(o_waterTileRenderer);
	}*/
	
	// Water layers are now ready.
	global.water_layers_ready = true;
}