
// loop through all layers in the room
var all_layers = layer_get_all();
for (var i = 0; i < array_length_1d(all_layers); ++i)
{
	var current_layer = all_layers[i];
	var layer_name = layer_get_name(current_layer);
	if (string_pos("doodad", layer_name) != 0)
	{
		doodadInitOnLayer(current_layer, string_pos("shadow", layer_name) != 0, false);
	}
}


// with all the building type, we need to make a collision area on top of it
with (ob_doodadModularBuilding)
{
	var l_doodad = id;
	var l_elevation = elevation;
	with (ob_doodad)
	{
		// If is on top of the doodad in the room editor
		//   and is colliding with the elevation
		if (index > l_doodad.index && position_meeting(x, y, l_elevation))
		{
			var z_delta = l_elevation.z - z;
			
			// Update all associated Z's.
			z += z_delta;
			if (iexists(collider))
				collider.z += z_delta;
			if (iexists(elevation))
				elevation.z += z_delta;
		}
	}
}