/// @description Debug information

/*var dx, dy;
dx = round(x);
dy = round(y);*/

if (Debug.visible)
{
	draw_set_color(c_lime);
	draw_line(x, y - z_height, x, y);
	draw_circle(x, y, 3, false);
}
/*
// Draw the player
var kPlayerSurfaceSize = 64;
var kPlayerSurfaceCenter = 32;
var l_playerBuffer = surface_create(kPlayerSurfaceSize, kPlayerSurfaceSize);
surface_set_target(l_playerBuffer);
draw_clear_alpha(c_white, 0.0);
{
	var ihead = pstats.m_head;
	var ibody = pstats.m_body;
	var igend = _gendToIndex(pstats.m_gender);
	
	if (sprite_index == s_heroSleepingH0)
	{
		var head = [s_heroSleepingH0, s_heroSleepingH1, s_heroSleepingH2];
		var gend = [s_heroSleepingG0, s_heroSleepingG1, s_heroSleepingG2];
		var bott = [s_heroSleepingB0, s_heroSleepingB1, s_heroSleepingB2];
		_drawChara(head[ihead], image_index, kPlayerSurfaceCenter);
		_drawChara(gend[igend], image_index, kPlayerSurfaceCenter);
		_drawChara(bott[ibody], image_index, kPlayerSurfaceCenter);
	}
	else if (sprite_index == s_charHeroStand)
	{
		var head = [s_heroStandH0, s_heroStandH1, s_heroStandH2];
		var body = [s_heroStandB0, s_heroStandB1, s_heroStandB2];
		_drawChara(head[ihead], image_index, kPlayerSurfaceCenter);
		_drawChara(body[ibody], image_index, kPlayerSurfaceCenter);
	}
	else
	{
		_drawChara(sprite_index, image_index, kPlayerSurfaceCenter);
	}
}
surface_reset_target();

// Draw the actual composited player
if ((!inWater && !inTar) || z_height > 1)
{	// Draw normal depth, but with the moAnimationYOffset change vs depthDrawSelf().
	var shadow_pct = max(0.75, sprite_height / 32.0);
	shadow_pct /= (1.0 + max(0.0, z_height) / 32.0);
	var shadow_w = shadow_pct * 6.0;
	var shadow_h = shadow_pct * 2.0;

	gpu_set_alphatestenable(false);
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	draw_set_color(c_ltgray);
	draw_ellipse(floor(dx - 1 - shadow_w), floor(dy - 1 - shadow_h), ceil(dx + shadow_w), ceil(dy + shadow_h), false);

	gpu_set_blendmode(bm_normal);
	gpu_set_alphatestenable(true);
	draw_surface(l_playerBuffer,
				 dx - kPlayerSurfaceCenter,
				 round(dy - z_height + moAnimationYOffset) - kPlayerSurfaceCenter);
}
else
{	// Draw in-liquid
	gpu_set_alphatestenable(false);
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	draw_set_color(c_ltgray);
	draw_ellipse(dx - 7 - 2, dy - 2 - 4 - 1, dx + 6 + 2, dy + 2 - 4 + 1, false);

	gpu_set_blendmode_ext(bm_dest_color, bm_src_color);
	draw_set_color(c_white);
	draw_ellipse(dx - 7 + 1, dy - 2 - 4, dx + 6 - 1, dy + 2 - 4, false);

	gpu_set_blendmode(bm_normal);
	gpu_set_alphatestenable(true);
	draw_surface_part(l_playerBuffer,
					 0, 0,
					 kPlayerSurfaceSize,
					 kPlayerSurfaceCenter + 2 - 8,
					 dx - kPlayerSurfaceCenter,
					 round(dy - z_height + moAnimationYOffset) - kPlayerSurfaceCenter);
}

// Free up temp buffer used for player
surface_free(l_playerBuffer);

// Draw the held item
if (inventory.belt_selection >= 0 && inventory.belt_selection < array_length_1d(inventory.belt))
{
	var balance_delta = m_itemBalanceSpringOffset;
	var held_item = inventory.belt[inventory.belt_selection];
	if (held_item.onUse == generalYeetableOnUse
		&& held_item.object_index != o_pickupJunk_Rock)
	{
		var item_sprite = object_get_sprite(held_item.object);
		var balance_step_x = 0.23 * balance_delta[0] + 0.4 * (sin(Time.time) + sin(Time.time * 0.74));
		var balance_step_y = (8 - balance_delta[1] * 0.1) - sqr(abs(balance_step_x)) * 0.25;
		for (var i = 0; i < held_item.count; ++i)
		{
			draw_sprite(item_sprite, 0,
						dx + i * balance_step_x,
						dy - z_height - 26 - i * balance_step_y);
		}
	}
}*/

if (Debug.visible)
{
	with (camera)
	{
		camPlayerDrawDebug();
	}
	draw_set_color(c_red);
	draw_set_font(f_04b03);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(x - 4, y - 32, string(meleeAtkCurrent));
	draw_text(x + 16, y - 32, string(meleeAtkTimer));
	draw_text(x - 4, y - 48, "z: " + string(z));
	draw_text(x + 24, y - 48, "z_height: " + string(z_height));
	draw_text(x - 4, y - 40, "depth: " + string(depth));
	draw_text(x - 4, y + 8, string(uAxis.value));
	draw_text(x + 16, y + 8, string(vAxis.value));
	draw_text(x - 4, y - 56, "xsp: " + string(xspeed));
	draw_text(x + 24, y - 56, "ysp: " + string(yspeed));
	draw_text(x - 16, y - 64, "fce:" + string(round(facingDirection)));
	draw_text(x + 24, y - 64, "aim:" + string(round(aimingDirection)));
	draw_text(x - 16, y - 72, "am2:" + string(round(aiming2Direction)));
	
	draw_text(x - 4, y + 16, "x: " + string(x));
	draw_text(x - 4, y + 24, "y: " + string(y));
}