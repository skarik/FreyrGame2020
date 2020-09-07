function livelySetupWaterRendering() {

	var all_layers = layer_get_all();

	for (var i = 0; i < array_length_1d(all_layers); ++i)
	{
		var tilemap = layer_tilemap_get_id(all_layers[i]);
		if (!layer_tilemap_exists(all_layers[i], tilemap))
			continue;
	
		// skip all collision water bits
		var do_collision = string_pos("colli", layer_get_name(all_layers[i])) != 0;
		if (do_collision)
			continue;
	
		var tileset_id = tilemap_get_tileset(tilemap);
		if (tileset_id == tileset0_Water /* || tileset_id == tileset1_Water*/)
		{
			debugOut("Found water graphics map \"" + layer_get_name(all_layers[i]) + "\"");
		
			layer_set_visible(all_layers[i], false);
		
			var renderer = inew(o_waterTiledRenderPass);
				renderer.target_layer = all_layers[i];
				renderer.target_tilemap = tilemap;
		}
	}


}
