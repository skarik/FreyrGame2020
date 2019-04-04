
// loop through all layers in the room
var all_layers = layer_get_all();
for (var i = 0; i < array_length_1d(all_layers); ++i)
{
	var current_layer = all_layers[i];
	var layer_name = layer_get_name(current_layer);
	if (string_pos("doodad", layer_name) != 0)
	{
		doodadInitOnLayer(current_layer, string_pos("shadow", layer_name) != 0);
	}
}

// todo: add a no-shadow variation