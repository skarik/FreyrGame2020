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
/*var arm_backing_index = 1;
if (pl.pstats.m_pitem[kPitemVoidCapacitor] >= 1 && pl.pstats.m_pitem[kPitemVoidAlternator])
{
	//draw_sprite(sui_roboArm, 1, dx, dy);
}
else if (pl.pstats.m_pitem[kPitemVoidCapacitor] >= 1)
{
	arm_backing_index = 3;
}
draw_sprite(sui_roboArm, arm_backing_index, dx, dy);*/

// Draw the bar backings
draw_sprite(sui_barsHealth, 0, dx, dy);
draw_sprite(sui_barsWill, 0, dx, dy + 19);
if (pl.pstats.m_pitem[kPitemVoidCapacitor] >= 1)
{
	draw_sprite(sui_barsMagicS, 0, dx, dy + 19 + 15);
}
draw_sprite(sui_barsHealthHandTopper, 0, dx + 113, dy); 

// draw the health bar
/*var health_percent = saturate(m_arm_healthbar_percent);
draw_sprite_part(sui_roboArm, 2,
				 0, 0,
				 5, 30 * health_percent,
				 dx + 16, dy + 32 + 30 * (1.0 - health_percent));*/
				 
// draw the health bar
var health_percent = saturate(m_arm_healthbar_percent);
for (var i = 0; i < 4; ++i)
{
	var health_fraction = (m_arm_healthbar_percent - 0.25 * i) * 4.0;
	
	if (health_fraction > 1.0)
	{
		draw_sprite(sui_barsHealthBip, 0, dx + 10 + 15 * i, dy + 3);
	}
	else if (health_fraction > 0.0)
	{
		draw_sprite_part(sui_barsHealthBip, 0, 0, 0, ceil(12 * health_fraction), 10, dx + 10 + 15 * i, dy + 3);
		// Draw a glow at the edge
		gpu_set_blendmode(bm_add);
		draw_sprite_ext(s_effectGradientLine, 0,
						dx + 10 + 15 * i + ceil(12 * health_fraction),
						dy + 3 + 5,
						0.5, 0.3,
						0.0, merge_color(c_white, c_maroon, 0.5), 1.0);
		gpu_set_blendmode(bm_normal);
	}
}
	
// draw the health text & icon
/*var l_healthTextY = dy + 32 + 30 * (1.0 - health_percent);
var l_colorRedBright = make_color_rgb(239, 58, 12);
var l_colorRedHighlight = make_color_rgb(239, 183, 117);
draw_sprite_ext(sui_heart, 0,
				dx + 16 + 14, l_healthTextY + 2,
				1.0, 1.0, 0.0, c_white, 1.0);
{
	var l_textSurface = surface_create(32, 16);
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
}*/

// draw health text
draw_set_font(global.font_arvo7);
draw_set_valign(fa_top);
draw_set_color(c_black);
var l_healthValue = ceil(pl.stats.m_healthMax * health_percent);
draw_set_halign(fa_left);
draw_text(dx + 88, dy + 2, string(floor(l_healthValue / 10.0)));
draw_set_halign(fa_right);
draw_text(dx + 98, dy + 2, string(floor(l_healthValue % 10.0)));
	
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

// draw void sparks
var l_draw_void_sparks = iexists(pl.currentHeldUsable) && pl.currentHeldUsable.object_index = o_potEnergy;
if (l_draw_void_sparks)
{
	draw_set_color(c_white);
	draw_circle(dx + 18, dy + 25, 5, false);
	draw_circle(dx + 18, dy + 25, 7, true);
}

// draw the will power
/*dx += 48;
draw_set_color(c_gold);
draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_font(f_04b03);
draw_text(dx - 1, dy +  0, "W");
draw_text(dx - 1, dy +  6, "I");
draw_text(dx - 1, dy + 12, "L");
draw_text(dx - 1, dy + 18, "L");

draw_set_color(c_white);
draw_rectangle(dx - 1, dy - 1, dx + 6, dy + 49, false);
draw_set_color(c_black);
draw_rectangle(dx, dy, dx + 5, dy + 48, false);
draw_set_color(c_gold);
if (pl.m_will > 0)
{	// draw total will
	draw_rectangle(dx, dy, dx + 5, dy + 48 * saturate(pl.m_will / pl.m_willMax), false);
}
else
{	// draw willpush blocks
	for (var i = 0; i < pl.m_willpush; ++i)
	{
		draw_rectangle(dx + 1,
					   dy + (i) * 8 + (0  ) + 1,
					   dx + 5 - 1,
					   dy + (i) * 8 + (8-2) + 1,
					   false);
	}
}*/

// draw the will bar
if (pl.m_will > 0)
{
	var will_width = 59 * saturate(pl.m_will / pl.m_willMax);
	draw_sprite_part(sui_barsWillBip, 0, 0, 0, will_width, 6, dx + 9, dy + 19 + 3);
	
	// Draw a glow at the edge
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(s_effectGradientLine, 0,
					dx + 9 + will_width,
					dy + 19 + 3 + 3,
					0.5, 0.2,
					0.0, merge_color(c_white, c_gold, 0.7), 1.0);
	gpu_set_blendmode(bm_normal);
}
// draw the pushwill bips
else
{
	for (var i = 0; i < pl.m_willpush; ++i)
	{
		draw_sprite(sui_barsWillBip, 1, dx + 9 + 14 * i, dy + 19 + 3);
	}
}

// draw pushwill text
draw_set_font(f_04b03);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);
var l_willValue = ceil(pl.m_will / 60.0);//ceil(pl.stats.m_healthMax * health_percent);
draw_text(dx + 85, dy + 19 + 3, string(floor(l_willValue / 10.0)));
draw_text(dx + 92, dy + 19 + 3, string(floor(l_willValue % 10.0)));