function questDebugDisplayFlags() {

	draw_set_font(f_04b03);
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);

	var map_size = ds_map_size(global.ctsBackend_QuestIds);
	var key = ds_map_find_first(global.ctsBackend_QuestIds);
	for (var i = 0; i < map_size; ++i)
	{
		var value = ds_map_find_value(global.ctsBackend_QuestIds, key);
	
		var str = key + " (" + string(value) + ")";
	
		draw_set_color(c_black);
		draw_set_alpha(image_alpha * 0.65);
		draw_rectangle(32,
					   128 + 9 * i - 8,
					   32 + 256,
					   128 + 9 * i + 0,
					   false);
	
		draw_set_color(c_white);
		draw_set_alpha(image_alpha * 1.0);
		draw_text(32,
				  128 + 9 * i,
				  str);
		draw_text(192,
				  128 + 9 * i,
				  string(questGetValue(value)));
	
	
		// Go to next key
		key = ds_map_find_next(global.ctsBackend_QuestIds, key);
	}


}
