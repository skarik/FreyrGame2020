var check_x = argument0;
var check_y = argument1;

var cel_x = floor(check_x / 16);
var cel_y = floor(check_y / 16);

// hit the material layers first
vtile_internal_query_material_maps();
for (var i = 0; i < array_length_1d(global.material_layers); ++i)
{
	var tilemap = global.material_layers[i];
	var tile = tilemap_get(tilemap, cel_x, cel_y);
	if (tile != 0)
		return tile_get_index(tile) + kTileIdInfoOffset * 2;
}

// set up all the collision layers too
var all_layers = layer_get_all();

for (var i = 0; i < array_length_1d(all_layers); ++i)
{
	var tilemap = layer_tilemap_get_id(all_layers[i]); // TODO: Cache the layers.
	if (!layer_tilemap_exists(all_layers[i], tilemap))
		continue;
		
	var tileset = tilemap_get_tileset(tilemap);
	if (tileset != tilesetCollision && tileset != tilesetMaterial)
	{
		var offset = (tileset == tileset0) ? 0 : kTileIdInfoOffset;
			//offset += (tileset != tilesetMaterial) ? 0 : kTileIdInfoOffset;
		var tile = tilemap_get(tilemap, cel_x, cel_y);
		//var tile_id = tile & 0xFF;

		//return tile_id + offset;
		if (tile != 0)
			return tile_get_index(tile) + offset; // slow, probably
	}
}

return -1;