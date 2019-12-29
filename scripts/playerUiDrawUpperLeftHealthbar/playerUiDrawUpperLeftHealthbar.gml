var dx, dy;
var pl = o_PlayerTest;

// health bar v2
dx = 5;
dy = 10;
// blend to center
dx = lerp(dx, GameCamera.width * 0.5 - 20, smoothstep(m_arm_center_blend));
dy = lerp(dy, GameCamera.height * 0.5 - 84 * 0.5, smoothstep(m_arm_center_blend));

// move off-screen for cutscenes
dy = lerp(dy, -200, smoothstep(m_inCutsceneBlend));

draw_set_alpha(1.0);

// darw the arm backing
var arm_backing_index = 1;
if (pl.pstats.m_pitem[kPitemVoidCapacitor] >= 1 && pl.pstats.m_pitem[kPitemVoidAlternator])
{
	//draw_sprite(sui_roboArm, 1, dx, dy);
}
else if (pl.pstats.m_pitem[kPitemVoidCapacitor] >= 1)
{
	arm_backing_index = 3;
}
draw_sprite(sui_roboArm, arm_backing_index, dx, dy);

// draw the health bar
var health_percent = saturate(m_arm_healthbar_percent);//clamp(pl.stats.m_health / pl.stats.m_healthMax, 0.0, 1.0);
draw_sprite_part(sui_roboArm, 2,
				 0, 0,
				 5, 30 * health_percent,
				 dx + 16, dy + 32 + 30 * (1.0 - health_percent));
	
// draw the health text & icon
var l_healthTextY = dy + 32 + 30 * (1.0 - health_percent);
var l_colorRedBright = make_color_rgb(239, 58, 12);
var l_colorRedHighlight = make_color_rgb(239, 183, 117);
draw_sprite_ext(sui_heart, 0,
				dx + 16 + 14, l_healthTextY + 2,
				1.0, 1.0, 0.0, c_white, 1.0);
{
	var l_textSurface = surface_create(32, 32);
	surface_set_target(l_textSurface);
	// Clear to transparent first
	draw_clear_alpha(c_black, 0.0);
	
	draw_set_font(f_04b03);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	// First, draw the highlight
	draw_set_color(l_colorRedHighlight);
	draw_text(0, 0, string(ceil(pl.stats.m_healthMax * health_percent)));
			  
	// Mask out the highlight
	gpu_set_blendmode_ext_sepalpha(bm_zero, bm_zero, bm_zero, bm_zero);
	draw_rectangle(0, 3, 32, 32, false);
	
	// Third, draw the other color
	gpu_set_blendmode_ext(bm_inv_dest_alpha, bm_one);
	draw_set_color(l_colorRedBright);
	draw_text(0, 0, string(ceil(pl.stats.m_healthMax * health_percent)));
			  
	// Reset drawing mode
	gpu_set_blendmode(bm_normal);
	draw_set_color(c_white);
	surface_reset_target();
	
	// draw the text surface
	draw_surface(l_textSurface, dx + 16 + 14 + 5, l_healthTextY - 1);
	
	// no longer need the text surface
	surface_free(l_textSurface);
}
	
// draw the charge bar
if (pl.pstats.m_pitem[kPitemVoidCapacitor] >= 1)
{
	var charge_percent = clamp(pl.m_voidPunch_fill, 0.0, 1.0);
	draw_sprite_part(sui_roboArm, 4,
					 0, 0,
					 5, 8 * charge_percent,
					 dx + 24, dy + 59 + 8 * (1.0 - charge_percent));
}

// draw any flash overlay
if (m_arm_flash > 0.0)
{
	shader_set(sh_colormaskAlphatest);
	draw_sprite_ext(sui_roboArm, arm_backing_index, dx, dy, 1.0, 1.0, 0.0, c_white, m_arm_flash);
	
	var flash_scale = 1.0 + 0.5 * (1.0 - m_arm_flash);
	draw_sprite_ext(sui_roboArm, arm_backing_index,
					dx - 20 * (flash_scale - 1.0),
					dy - 84 * 0.5 * (flash_scale - 1.0),
					flash_scale,
					flash_scale,
					0.0, c_white, m_arm_flash * 0.5);
	shader_reset();
}

// draw the void cap coming in
if (m_arm_voidcap_draw_intro)
{
	for (var i = 0; i < 4; i += 1)
	{
		draw_sprite_ext(sui_roboArm, 5,
					dx + 22 + GameCamera.width * 0.5 * expoInOut(saturate(1.0 - m_arm_voidcap_blend + i * 0.02)),
					dy + 59 - 4,
					1.0, 1.0, 0.0, c_white, 0.5 / i);
		draw_sprite_ext(sui_roboArm, 5,
					dx + 22 + GameCamera.width * 0.5 * expoInOut(saturate(1.0 - m_arm_voidcap_blend + i * 0.02)),
					dy + 59 - 4,
					1.0, 1.0, 0.0, c_white, 0.5 / i);
	}
	
	draw_sprite(sui_roboArm, 5,
				dx + 22 + GameCamera.width * 0.5 * expoInOut(1.0 - m_arm_voidcap_blend),
				dy + 59 - 4);
}