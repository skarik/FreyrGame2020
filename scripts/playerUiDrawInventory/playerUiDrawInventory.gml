var dx, dy;

// inventory:
var inventory = o_PlayerTest.inventory;
{
	// update the selector
	if (m_inventory_selectorTarget != inventory.belt_selection)
	{
		//if (m_inventory_selectorBlend <= 0.00 || m_inventory_selectorBlend >= 1.00)
		//{
		m_inventory_selectorStart = m_inventory_selector;
		m_inventory_selectorBlend = 0.00;
		//}
		m_inventory_selectorTarget = inventory.belt_selection;
		m_inventory_selectorTimerCd = 1.0;
		
		m_inventory_selectorNameTimerCd = 3.0;
	}
	
	// Move the selector around
	m_inventory_selector = lerp(
		m_inventory_selectorStart, 
		m_inventory_selectorTarget,
		bouncestep(smoothstep(m_inventory_selectorBlend))
		);
	m_inventory_selectorBlend = saturate(m_inventory_selectorBlend + Time.deltaTime * 3.0);
	
	// Cool off the selector
	m_inventory_selectorTimerCd -= Time.deltaTime;
	// Perform that blend for the blender
	if (m_inventory_selectorTimerCd > 0.0)
		m_inventory_selectorBlendCruft = saturate(m_inventory_selectorBlendCruft + Time.deltaTime * 6.0);
	else
		m_inventory_selectorBlendCruft = saturate(m_inventory_selectorBlendCruft - Time.deltaTime * 2.0);
		
	// if name doesn't match, we need to swap names
	if (m_inventory_selectorName != inventory.belt[inventory.belt_selection].name)
	{
		m_inventory_selectorNameTimerCd = -1.0;
		if (m_inventory_selectorNameBlend <= 0.0)
		{
			m_inventory_selectorName = inventory.belt[inventory.belt_selection].name;
			m_inventory_selectorNameTimerCd = 3.0;
		}
	}
	else
	{
		// if we're planting get rid of cooldown
		if (inventory.belt[inventory.belt_selection].type == kItemPickupSeed && o_PlayerTest.m_plantable)
		{
			m_inventory_selectorNameTimerCd = max(m_inventory_selectorNameTimerCd, 2.0);
		}
	}
	
	// Cool off the selector
	m_inventory_selectorNameTimerCd -= Time.deltaTime;
	// Perform that blend for the blender
	if (m_inventory_selectorNameTimerCd > 0.0)
		m_inventory_selectorNameBlend = saturate(m_inventory_selectorNameBlend + Time.deltaTime * 5.0);
	else
		m_inventory_selectorNameBlend = saturate(m_inventory_selectorNameBlend - Time.deltaTime * 5.0);
}
{
	dx = 5;
	dy = GameCamera.height - 30;
	var dspace = 25;
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
	draw_set_color(c_white);
	draw_set_font(f_04b03);
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	for (var i = 0; i < inventory.belt_size; ++i)
	{
		draw_sprite(sui_bagBox, 0, dx + dspace * i, dy );
	
		if (inventory.belt[i].object != null)
		{
			draw_sprite(object_get_sprite(inventory.belt[i].object), 0, dx + dspace * i + 15, dy + 15);
			draw_text(dx + dspace * i + 25, dy + 25, string(inventory.belt[i].count));
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
	}
	// inventory selector fg
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
	draw_sprite(sui_arcaneSelect, 0, dx + dspace * selector + 15, dy + 15);
	// inventory item name
	surface_reset_target();
	surface_set_target(m_surface);
	draw_set_font(f_josefinSlab9);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_text(
		dx + 8 - 100.0 * smoothstep(1.0 - m_inventory_selectorNameBlend), dy - 20,
		m_inventory_selectorName);
		
	// reset target to proper one
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
}