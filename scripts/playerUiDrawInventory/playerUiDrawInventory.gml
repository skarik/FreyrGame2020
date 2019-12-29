var dx, dy;
var inventory = o_PlayerTest.inventory;

draw_set_alpha(1.0);

// draw the belt
{
	var dspace = 25;
	dx = 5 + smoothstep(m_bag_totalBlend) * (GameCamera.width * 0.5 - 5 - dspace * 6 * 0.5);
	dy = GameCamera.height - 30 + smoothstep(m_inCutsceneBlend) * 80;
	
	// save the position
	m_belt_base_x = dx;
	m_belt_base_y = dy;
	
	// inventory selector bg
	surface_reset_target();
	surface_set_target(m_surface);
	var selector = m_inventory_selector;
	draw_sprite_ext(sui_gearMedium, 0,
		dx + dspace * selector + 15 - 6,
		dy + 15 + 6 + 40 * smoothstep(1.0 - m_inventory_selectorBlendCruft),
		1.0, 1.0, current_time * 0.01 - m_inventory_selector * 130.0, c_white, 1.0);
	draw_sprite_ext(sui_gearSmall, 0,
		dx + dspace * selector + 15 + 10,
		dy + 15 - 10 + 40 * bouncestep(smoothstep(1.0 - m_inventory_selectorBlendCruft)),
		1.0, 1.0, - current_time * 0.02 + m_inventory_selector * 230.0, c_white, 1.0);
	// inventory selector
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
	for (var i = 0; i < inventory.belt_size; ++i)
	{
		draw_sprite(sui_bagBox, 0, dx + dspace * i, dy );
	
		if (inventory.belt[i].object != null)
		{
			draw_sprite(object_get_sprite(inventory.belt[i].object), 0, dx + dspace * i + 15, dy + 15);
			
			draw_set_color(c_white);
			draw_set_font(f_04b03);
			draw_set_halign(fa_right);
			draw_set_valign(fa_bottom);
			draw_text(dx + dspace * i + 25, dy + 25, string(inventory.belt[i].count));
			
			// Run UI script
			if (inventory.belt[i].onUi != itemNullUiScript)
			{
				var is_hovered = (i == m_belt_hover) || (i == m_belt_selection);
				var y_offset = -8.0 * saturate(1.5 - abs(i - m_inventory_selector) * 2.0);
				script_execute(inventory.belt[i].onUi, // Following are arguments for onUi
							   inventory.belt[i].object,
							   dx + dspace * i + 15, dy + 15 + y_offset,
							   saturate( saturate(1.5 - abs(i - m_inventory_selector) * 2.0) + (is_hovered ? 1.0 : 0.0) ),
							   (i == inventory.belt_selection) || is_hovered, 
							   kItemUiCategoryBelt);
				draw_set_alpha(1.0);
			}
		}
		/*if (inventory.belt[i].type == kItemPickupSeed)
		{
			gpu_set_blendmode(bm_add);
			draw_set_color(c_lime);
			draw_rectangle(
				dx + dspace * i + 15 - 11, dy + 15 - 11,
				dx + dspace * i + 15 + 9, dy + 15 + 9,
				true);
			draw_set_color(c_white);
			gpu_set_blendmode(bm_normal);
		}*/
		
		// draw the hover selection
		if (i == m_belt_hover)
		{
			gpu_set_blendmode(bm_add);
			draw_set_color(merge_color(c_dkgray, c_gold, sin(current_time * 0.01) * 0.5 + 0.5));
			draw_rectangle(
				dx + dspace * i + 15 - 11, dy + 15 - 11,
				dx + dspace * i + 15 + 9, dy + 15 + 9,
				true);
			draw_set_color(c_white);
			gpu_set_blendmode(bm_normal);
		}
		// draw the REAAAAL selection
		if (i == m_belt_selection)
		{
			gpu_set_blendmode(bm_add);
			draw_set_color(c_gold);
			draw_rectangle(
				dx + dspace * i + 15 - 10, dy + 15 - 10,
				dx + dspace * i + 15 + 8, dy + 15 + 8,
				true);
			draw_set_color(c_white);
			gpu_set_blendmode(bm_normal);
		}
	}
	// inventory selector fg
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
	draw_sprite(sui_arcaneSelect, 0, dx + dspace * selector + 15, dy + 15);
	// inventory item name
	surface_reset_target();
	surface_set_target(m_surface);
	draw_set_font(global.font_arvo9);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_set_alpha((1.0 - m_bag_totalBlend) * saturate(m_inventory_selectorNameBlend * 4.0));
	draw_text_spaced(dx + 4 - 100.0 * smoothstep(1.0 - m_inventory_selectorNameBlend), dy - 25,
					 m_inventory_selectorName, 3);
		
	// reset target to proper one
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
	draw_set_alpha(1.0);
}