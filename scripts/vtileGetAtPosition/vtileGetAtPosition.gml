/// @function vtileGetAtPosition(x, y)
/// @param x
/// @param y
function vtileGetAtPosition(argument0, argument1) {

	var check_x = argument0;
	var check_y = argument1;

	var cel_x = int64(check_x) >> 4;
	var cel_y = int64(check_y) >> 4;

	var layer_count;

	// hit the material layers first
	vtile_internal_query_material_maps();
	layer_count = array_length_1d(global.material_layers);
	for (var i = 0; i < layer_count; ++i)
	{
		var tilemap = global.material_layers[i];
		var tile = tilemap_get(tilemap, cel_x, cel_y);
		if (tile != 0)
			return tile_get_index(tile) + kTileIdInfoOffset * 2;
	}

	// check all the visual layers too
	layer_count = array_length_1d(global.material_tile_layers);
	for (var i = 0; i < layer_count; ++i)
	{
		var tilemap = global.material_tile_layers[i];
		var tileset = tilemap_get_tileset(tilemap);
		var offset = (tileset == tileset0) ? 0 : kTileIdInfoOffset;
		var tile = tilemap_get(tilemap, cel_x, cel_y);
	
		if (tile != 0)
			return tile_get_index(tile) + offset; // slow, probably
	}

	return -1;


}
