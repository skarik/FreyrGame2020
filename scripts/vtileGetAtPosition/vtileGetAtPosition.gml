var check_x = argument0;
var check_y = argument1;

var cel_x = floor(check_x / 16);
var cel_y = floor(check_y / 16);

// set up all the collision layers too
var all_layers = layer_get_all();

for (var i = 0; i < array_length_1d(all_layers); ++i)
{
	var tilemap = layer_tilemap_get_id(all_layers[i]);
	if (!layer_tilemap_exists(all_layers[i], tilemap))
		continue;
		
	var tileset = tilemap_get_tileset(tilemap);
	if (tileset != tilesetCollision)
	{
		var offset = (tileset == tileset0) ? 0 : kTileIdInfoOffset;
		var tile = tilemap_get(tilemap, cel_x, cel_y);
		//var tile_id = tile & 0xFF;

		//return tile_id + offset;
		return tile_get_index(tile) + offset; // slow, probably
	}
}

return -1;