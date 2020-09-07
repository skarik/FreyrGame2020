///@function procRoomGetBBox(room)
///@param room
///@return aBBox
function procRoomGetBBox(argument0) {

	var bbox = abbox_create(0, 0, 0, 0);

	layer_set_target_room(argument0);
	var all_layers = layer_get_all();
	var layer_count = array_length_1d(all_layers);
	for (var i = 0; i < layer_count; ++i)
	{
		var currentLayer = all_layers[i];
	
		var tilemap = layer_tilemap_get_id(currentLayer);
		if (!layer_tilemap_exists(currentLayer, tilemap))
			continue;
	
		var v_w = tilemap_get_width(tilemap) * tilemap_get_tile_width(tilemap);
		var v_h = tilemap_get_height(tilemap) * tilemap_get_tile_height(tilemap);
	
		bbox = abbox_encompassTo(bbox, [v_w, v_h]);
	}
	layer_reset_target_room();

	return bbox;


}
