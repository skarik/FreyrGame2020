/// @description Update depth and positions

var minimum_depth = layersMaxDepth;
if (exists(o_waterMetalballRenderer))
{
	minimum_depth = o_waterMetalballRenderer.depth - 1;
}

var y_position_offset = round(sin(current_time * 0.0015 + id) * 1.4);
var layer_count = array_length_1d(layers);
for (var i = 0; i < layer_count; ++i)
{
	var current_layer = layers[i];
	if (layer_exists(current_layer))
	{
		layer_y(current_layer, y_position_offset);
		/*layer_depth(current_layer,
			((layersDepth[i] - layersMaxDepth) / (layersMaxDepth - layersMinDepth))
			 * (minimum_depth - layersMinDepth) + minimum_depth);*/
	}
}

var doodad_count = array_length_1d(doodads);
for (var i = 0; i < doodad_count; ++i)
{
	var current_doodad = doodads[i];
	current_doodad.y = doodadsY[i] + y_position_offset;
}

// Handle other effects
var elevation_count = array_length_1d(elevationSources);
var lively = id;
with (o_ptcFootstep)
{	// todo: cache footsteps
	for (var i = 0; i < elevation_count; ++i)
	{
		if (place_meeting(x, y, lively.elevationSources[i]))
		{
			y = ystart + y_position_offset;
		}
	}
}