var dx, dy, dply;

if (m_farmoverlay_blend > 0.0)
{
	dx = m_farmoverlay_targetPosition[0] - (GameCamera.x - GameCamera.width / 2);
	dy = m_farmoverlay_targetPosition[1] - (GameCamera.y - GameCamera.height / 2);
	dply = m_player.y - (GameCamera.y - GameCamera.height / 2);
	
	// make it shrink in
	var l_wo = floor(sqr(1.0 - m_farmoverlay_blend) * 16.0);
	
	// draw selection reticle
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	/*draw_set_alpha(0.8 * m_farmoverlay_blend);
	draw_set_color(c_white);
	draw_rectangle(dx - l_wo, dy - l_wo, dx + 15 + l_wo, dy + 15 + l_wo, true);*/
	draw_set_color(m_farmoverlay_targetColor);
	draw_set_alpha(0.6 * m_farmoverlay_blend);
	draw_rectangle(dx + 1 - l_wo, dy + 1 - l_wo, dx + 14 + l_wo, dy + 14 + l_wo, false);
	draw_set_alpha(0.8 * m_farmoverlay_blend);
	draw_rectangle(dx + 1 - l_wo, dy + 1 - l_wo, dx + 14 + l_wo, dy + 14 + l_wo, true);
	draw_set_alpha(1.0 * m_farmoverlay_blend);
	
	// set target to display text & control properly (w/ outline)
	surface_reset_target();
	surface_set_target(m_surface);
	
	draw_set_alpha(1.0 * sqrt(saturate(m_farmoverlay_blend * 2.0 - 1.0)));
	draw_set_font(global.font_arvo9);
	/*draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_color(c_white);
	draw_text_spaced(dx + 8, dy - 4, m_farmoverlay_targetString, 2);*/
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text_spaced(dx + 8, dply - 40, "  " + m_farmoverlay_targetString, 2);
	drawControl(dx - string_length(m_farmoverlay_targetString) * 5 * 0.5,
				dply - 40,
				null, null,
				m_farmoverlay_targetControl, m_player.lastControlType, m_player.lastGamepadType);
	
	draw_set_alpha(1.0);

	// reset target to original one
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
}

// draw text for crop type
if (exists(m_player.currentCrop))
{
	// set target to display text & control properly (w/ outline)
	surface_reset_target();
	surface_set_target(m_surface);
	
	draw_set_alpha(1.0);
	draw_set_font(global.font_arvo7);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_text_spaced(m_player.currentCrop.x - (GameCamera.x - GameCamera.width / 2),
					 m_player.currentCrop.y - (GameCamera.y - GameCamera.height / 2) + 8, m_player.currentCrop.m_cropName, 2);
	
	// reset target to original one
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
}

/*if (0)
{
	// tillable
	if (instance_exists(o_PlayerTest.currentTillable) && !exists(ob_CtsTalker) && !o_PlayerTest.isBlocking && o_PlayerTest.moEnabled)
	{
		var tillable = o_PlayerTest.currentTillable;
		dx = tillable.x - (GameCamera.x - GameCamera.width / 2);
		dy = tillable.y - (GameCamera.y - GameCamera.height / 2);
	
		gpu_set_blendenable(true);
		gpu_set_blendmode(bm_normal);
		draw_set_alpha(0.7);
		draw_set_color(c_white);
		draw_rectangle(dx, dy, dx + 15, dy + 15, true);
		draw_set_color(c_crystalblue);
		draw_rectangle(dx + 1, dy + 1, dx + 14, dy + 14, true);
		draw_set_alpha(1.0);
	
		// set target to display text properly
		surface_reset_target();
		surface_set_target(m_surface);
	
		draw_set_font(f_josefinSlab9);
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_set_color(c_white);
		if (!tillable.tilled)
		{
			draw_text(dx + 8, dy - 4, "Till");
		}
	
		// reset target to proper one
		surface_reset_target();
		surface_set_target(m_surfaceLightweight);
	}
	if (o_PlayerTest.m_till_filldirt && !exists(ob_CtsTalker) && !o_PlayerTest.isBlocking && o_PlayerTest.moEnabled)
	{
		dx = o_PlayerTest.m_till_x - 8 - (GameCamera.x - GameCamera.width / 2);
		dy = o_PlayerTest.m_till_y - 8 - (GameCamera.y - GameCamera.height / 2);
	
		gpu_set_blendenable(true);
		gpu_set_blendmode(bm_normal);
		draw_set_color(c_white);
		draw_rectangle(dx, dy, dx + 15, dy + 15, true);
		draw_set_color(c_crystalblue);
		draw_rectangle(dx + 1, dy + 1, dx + 14, dy + 14, true);
		draw_set_alpha(1.0);
	
		// set target to display text properly
		surface_reset_target();
		surface_set_target(m_surface);
	
		draw_set_font(f_josefinSlab9);
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
		draw_set_color(c_white);
		draw_text(dx + 8, dy - 4, "Plow");
	
		// reset target to proper one
		surface_reset_target();
		surface_set_target(m_surfaceLightweight);
	}
	// buildable
	if (o_PlayerTest.currentBuildable && !exists(ob_CtsTalker))
	{
		dx = o_PlayerTest.currentBuildableX - (GameCamera.x - GameCamera.width / 2);
		dy = o_PlayerTest.currentBuildableY - (GameCamera.y - GameCamera.height / 2);
	
		gpu_set_blendenable(true);
		gpu_set_blendmode(bm_normal);
		draw_set_color(c_blue);
		draw_set_alpha(0.9);
		draw_rectangle(dx + 1, dy + 1, dx + 14, dy + 14, true);
		draw_set_alpha(1.0);
	}
	// tillable timer
	if (o_PlayerTest.m_isTilling)
	{
		dx = o_PlayerTest.x - (GameCamera.x - GameCamera.width / 2);
		dy = o_PlayerTest.y - (GameCamera.y - GameCamera.height / 2);
	
		draw_set_color(c_black);
		draw_rectangle(dx - 6, dy - 25, dx + 6, dy - 21, false);
		draw_set_color(c_white);
		draw_rectangle(dx - 5, dy - 24, dx - 5 + 10 * clamp(o_PlayerTest.m_till_timer, 0.0, 1.0), dy - 22, false);
	}
	// plantable
	if (o_PlayerTest.m_plantable)
	{
		dx = o_PlayerTest.m_plant_x - 8 - (GameCamera.x - GameCamera.width / 2);
		dy = o_PlayerTest.m_plant_y - 8 - (GameCamera.y - GameCamera.height / 2);
	
		gpu_set_blendenable(true);
		gpu_set_blendmode(bm_normal);
		//draw_set_color(c_blue);
		draw_set_color(c_gold);
		draw_set_alpha(0.9);
		draw_rectangle(dx + 1, dy + 1, dx + 14, dy + 14, true);
		draw_set_alpha(1.0);
	}
}*/