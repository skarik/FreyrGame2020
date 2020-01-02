/// @description Update snow buffer

if (!surface_exists(m_snowBuffer))
{
	m_snowBuffer = surface_create(room_width, room_height);	
	
	surface_set_target(m_snowBuffer);
	
		// Clear to full white for full density on all channels.
		draw_clear_alpha(c_white, 1.0);
	
		// Remove near any water (via rendering them normally)
		var prev_view_x = GameCamera.view_x;
		var prev_view_y = GameCamera.view_y;
		GameCamera.view_x = 0;
		GameCamera.view_y = 0;
		gpu_set_blendmode_ext(bm_zero, bm_inv_src_color);
		with (o_waterMetaball)
		{
			event_user(0);
		}
		GameCamera.view_x = prev_view_x;
		GameCamera.view_y = prev_view_y;
	
	surface_reset_target();
	
	// Create a temp buffer and fix the colors
	var l_swizzleBuffer = surface_create(room_width, room_height);
	gpu_set_blendenable(false);
	surface_set_target(l_swizzleBuffer);
		shader_set(sh_bufferedSnowInit_Swizzle);
		draw_surface(m_snowBuffer, 0 ,0);
		shader_reset();
	surface_reset_target();
	gpu_set_blendenable(true);

	// Clear out the collidable areas, vary the elevation
	surface_set_target(m_snowBuffer);
	
		// Copy swizzle over
		gpu_set_blendenable(false);
		draw_surface(l_swizzleBuffer, 0, 0);
		gpu_set_blendenable(true);
	
		// Draw collidable areas
		gpu_set_alphatestenable(true);
		gpu_set_blendmode_ext(bm_zero, bm_zero);
		with (ob_collider) {
			draw_self(); // todo: change to collision box
		}
	
		// Vary elevation & add noise
		gpu_set_alphatestenable(false);
		gpu_set_blendmode_ext(bm_zero, bm_inv_src_color);
		draw_sprite_tiled_ext(s_effectNoise, 0, 0, 0, 1.0, 1.0, make_color_rgb(0, 255, 0), 1.0);
		draw_sprite_tiled_ext(s_effectNoise, 0, 32, 32, 0.9, 0.9, make_color_rgb(0, 0, 64), 1.0);
		draw_sprite_tiled_ext(s_effectNoise, 0, 9, 64, 1.1, 1.1, make_color_rgb(0, 0, 64), 1.0);
	
	surface_reset_target();
	
	// Remove temp swizzle
	surface_free(l_swizzleBuffer);
	
	// Clear out wierd draw state
	gpu_set_blendmode(bm_normal);
}

// Dig out snow nearby characters
surface_set_target(m_snowBuffer);
with (ob_character)
{
	draw_set_color(c_black);
	draw_circle(x, y - 2, random(2) + 3, false);
}
surface_reset_target();
