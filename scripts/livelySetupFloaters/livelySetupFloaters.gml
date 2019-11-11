var layers_all = layer_get_all();
var layer_count = array_length_1d(layers_all);

for (var i = 0; i < layer_count; ++i)
{
	var current_layer = layers_all[i];
	
	//debugOut(layer_get_name(current_layer));
	// Does this layer's name have "float" in it?
	var current_name = layer_get_name(current_layer);
	var keyname_search_position = string_pos("float", current_name);
	var keyname_post_numeral = string_char_at(current_name, min(keyname_search_position + 5, string_length(current_name)));
	if (keyname_search_position != 0 && is_numeral(keyname_post_numeral))
	{
		debugOut("Found initial float layer \"" + current_name + "\"");

		// Grab the number after it:
		var keyname_id = keyname_post_numeral;
		var key_i = 6;
		var key_next = string_char_at(current_name, min(keyname_search_position + key_i, string_length(current_name)));
		while (is_numeral(key_next) && key_i < string_length(current_name))
		{
			keyname_id += key_next;
			key_i++;
			key_next = string_char_at(current_name, min(keyname_search_position + key_i, string_length(current_name)));
		}
		
		debugOut("Key ID is \"" + keyname_id + "\"");
		
		// Generate bungled name now
		var keyname_replacement = "float" + "X" + keyname_id;
		
		// Create the lively object that will manage all these layers
		var floater_manager = new(o_livelyFloatingLayerGroup);
		
		// Finally, look for all matches to that number:
		var keyname_full = "float" + keyname_id;
		
		for (var j = 0; j < layer_count; ++j)
		{
			var target_layer = layers_all[j];
			var target_layer_name = layer_get_name(target_layer);
			if (string_pos(keyname_full, target_layer_name))
			{
				// Change the name to prevent a double key
				target_layer_name = string_replace(target_layer_name, keyname_full, keyname_replacement);
				
				// Save the layer in the manager
				with (floater_manager)
				{
					var next_index = array_length_1d(layers);
					layers[next_index] = target_layer;
					layersDepth[next_index] = layer_get_depth(target_layer);
					layersMaxDepth = max(layersDepth[next_index], layersMaxDepth);
					layersMinDepth = max(layersDepth[next_index], layersMinDepth);
				}
			}
		}
		
		// Onto the next layer group!
	}
}