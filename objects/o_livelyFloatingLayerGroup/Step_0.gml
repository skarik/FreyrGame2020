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