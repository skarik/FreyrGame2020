function playerUiDrawChest() {
	var list_sprite_width = sprite_get_width(sui_scribbleBackground);
	var dx, dy;
	dx = (Screen.width / Screen.pixelScale) / 2 - list_sprite_width * 0.5 - 20;
	dy = round(5);
	dy -= (1.0 - bouncestep(smoothstep(m_bag_totalBlend))) * 100 + (1.0 - smoothstep(m_bag_totalBlend)) * 100;

	var smooth_blend = smoothstep(m_sbag_blend);

	surface_reset_target();
	surface_set_target(m_surface);

	if (o_PlayerTest.m_currentChest != null)
	{
		var chest = o_PlayerTest.m_currentChest;
		// draw the chest nonsense
		var chest_size = inventoryGetCount(chest);
	
		// draw a long note that expands based on the number of items
		var list_height = 21 * max(3, chest_size);
		var actual_height = min(sprite_get_height(sui_scribbleBackground) - 20, list_height);
	
		// push down based on the height
		dy += max(0, 170 - (actual_height + 20));
	
		m_chest_base_x = dx;
		m_chest_base_y = dy;
	
		// draw start of list
		draw_sprite_part(sui_scribbleBackground, 0,
						 0, 0,
						 list_sprite_width * 0.5 - 20,
						 actual_height,
						 dx,
						 dy);
		draw_sprite_part(sui_scribbleBackground, 0,
						 list_sprite_width * 0.5 + 20, 0,
						 list_sprite_width * 0.5 - 20,
						 actual_height,
						 dx + list_sprite_width * 0.5 + 60,
						 dy);
		for (var i = 0; i < 2; ++i)
			draw_sprite_part(sui_scribbleBackground, 0,
							 list_sprite_width * 0.5 - 20, 0,
							 40,
							 actual_height,
							 dx + list_sprite_width * 0.5 - 20 + 40*i,
							 dy);
		// draw end of list
		draw_sprite_part(sui_scribbleBackground, 0,
						 0, sprite_get_height(sui_scribbleBackground) - 20,
						 list_sprite_width * 0.5 - 20,
						 20,
						 dx,
						 dy + actual_height);
		draw_sprite_part(sui_scribbleBackground, 0,
						 list_sprite_width * 0.5 + 20, sprite_get_height(sui_scribbleBackground) - 20,
						 list_sprite_width * 0.5 - 20,
						 20,
						 dx + list_sprite_width * 0.5 + 60,
						 dy + actual_height);
		for (var i = 0; i < 2; ++i)
			draw_sprite_part(sui_scribbleBackground, 0,
							 list_sprite_width * 0.5 - 20, sprite_get_height(sui_scribbleBackground) - 20,
							 40,
							 20,
							 dx + list_sprite_width * 0.5 - 20 + 40*i,
							 dy + actual_height);
	
		// draw the text items
	
		var dx_text = dx + 3;
		var dy_text = dy + 8;
		var dspace = 20;
	
		if (chest_size == 0)
		{
			draw_set_font(global.font_arvo9);
			draw_set_alpha(1.0);
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			draw_set_color(c_black);
			draw_text_spaced(dx_text + 1, dy_text + dspace * 0.5, "[Empty Chest]", 2);
		}
		else
		{
			//draw_text(dx_text, dy_text + 5, "<Filled Chest>");
			for (var i = 0; i < chest_size; ++i)
			{
				if (iexists(chest.item[i]) && chest.item[i].object != null)
				{
					draw_sprite(object_get_sprite(chest.item[i].object), 0, dx_text + 15, dy_text + dspace * 0.5 + i * dspace);
				
					draw_set_color(c_black);
					draw_set_font(f_04b03);
					draw_set_halign(fa_right);
					draw_set_valign(fa_bottom);
					draw_text(dx_text + 30, dy_text + 16 + i * dspace, string(chest.item[i].count));
				
					draw_set_font(global.font_arvo9);
					draw_set_alpha(1.0);
					draw_set_halign(fa_left);
					draw_set_valign(fa_middle);
					draw_set_color(c_black);
					draw_text_spaced(dx_text + 45, dy_text + i * dspace + dspace * 0.5, string(chest.item[i].name), 2);
				}
				else
				{
					draw_set_font(global.font_arvo9);
					draw_set_alpha(1.0);
					draw_set_halign(fa_left);
					draw_set_valign(fa_middle);
					draw_set_color(c_black);
					draw_text_spaced(dx_text + 45, dy_text + i * dspace + dspace * 0.5, "[Empty Spot]", 2);
				}
			}
		}
	
	
		if (m_chest_hover != null)
		{
			gpu_set_blendmode(bm_add);
			draw_set_color(merge_color(c_dkgray, c_gold, sin(current_time * 0.01) * 0.5 + 0.5));
			draw_rectangle(
				dx_text,
				dy_text + m_chest_hover * dspace,
				dx_text + list_sprite_width + 38 - (dx_text - dx),
				dy_text + m_chest_hover * dspace + dspace,
				true);
			draw_set_color(c_white);
			gpu_set_blendmode(bm_normal);
		}
		if (m_chest_selection != null)
		{
			gpu_set_blendmode(bm_add);
			draw_set_color(c_gold);
			draw_rectangle(
				dx_text - 1,
				dy_text + m_chest_selection * dspace - 1,
				dx_text + list_sprite_width + 38 - (dx_text - dx) + 1,
				dy_text + m_chest_selection * dspace + dspace + 1,
				true);
			draw_set_color(c_white);
			gpu_set_blendmode(bm_normal);
		}
	
	}


}
