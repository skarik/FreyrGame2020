/// @description On Trigger
#macro kLayerAction_Show 0
#macro kLayerAction_Hide 1
#macro kLayerAction_Delete 2

//m_targetLayer
//m_layerAction

// Find the layer with the matching name
var all_layers = layer_get_all();
for (var i = 0; i < array_length_1d(all_layers); ++i)
{
	var current_layer = all_layers[i];
	var layer_name = layer_get_name(current_layer);
	if (layer_name == m_targetLayer)
	{
		if (m_layerAction == kLayerAction_Show)
		{
			layer_set_visible(current_layer, true);
		}
		else if (m_layerAction == kLayerAction_Hide)
		{
			layer_set_visible(current_layer, false);
			with (ob_doodad)
			{
				if (source_layer == current_layer)
				{
					instance_deactivate_object(this);
				}
			}
		}
		else if (m_layerAction == kLayerAction_Delete)
		{
			layer_destroy(current_layer);
			with (ob_doodad)
			{
				if (source_layer == current_layer)
				{
					idelete(this);
				}
			}
		}
	}
}