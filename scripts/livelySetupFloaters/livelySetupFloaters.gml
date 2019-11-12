#macro kLayerYProcessed 101

var layers_all = layer_get_all();
var layer_count = array_length_1d(layers_all);

for (var i = 0; i < layer_count; ++i)
{
	var current_layer = layers_all[i];
	
	if (layer_get_y(current_layer) == kLayerYProcessed)
		continue;
	
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
				
				// If the layer is a doodad layer...
				if (string_pos("doodad", target_layer_name))
				{
					// Find all doodads with matching name
					with (ob_doodad)
					{
						if (source_layer == target_layer)
						{
							var next_index = array_length_1d(floater_manager.doodads);
							floater_manager.doodads[next_index] = id;
							floater_manager.doodadsY[next_index] = y;
						}
					}
				}
				
				var all_elements = layer_get_all_elements(target_layer);
				var all_elements_count = array_length_1d(all_elements);
				
				// If the layer has any elevation areas...
				if (all_elements_count > 0 && layer_get_element_type(all_elements[0]) == layerelementtype_instance)
				{
					for (var i = 0; i < all_elements_count; ++i)
					{
						var instance = layer_instance_get_instance(all_elements[i]);
						if (object_get_parent(instance.object_index) == ob_elevationArea)
						{
							var next_index = array_length_1d(floater_manager.elevationSources);
							floater_manager.elevationSources[next_index] = instance;
						}
						else if (instance.object_index == o_doodadMithraBridgeEndpoint
							|| instance.object_index == o_doodadMithraBridgeEndpoint)
						{
							var next_index = array_length_1d(floater_manager.instances);
							floater_manager.instances[next_index] = instance;
							floater_manager.instancesY[next_index] = instance.y;
						}
					}
				}
			}
			
			// Replace layer name now
			//layer_
			layer_y(target_layer, kLayerYProcessed);
		}
		
		// Onto the next layer group!
	}
}

// Reset all the Y-fucking
for (var i = 0; i < layer_count; ++i)
{
	var current_layer = layers_all[i];
	if (layer_get_y(current_layer) == kLayerYProcessed)
		layer_y(current_layer, 0);
}