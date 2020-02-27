var dx, dy;
dx = round(x);
dy = round(y);

if (Debug.visible)
{
	draw_set_color(c_lime);
	draw_line(x, y - z_height, x, y);
	draw_circle(x, y, 3, false);
}

if ((!inWater && !inTar) || z_height > 1)
{
	depthDrawSelf();
}
else
{
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
	draw_sprite_part(sprite_index, image_index,
					 0, 0,
					 sprite_get_width(sprite_index), sprite_get_height(sprite_index) - 8,
					 x - sprite_get_xoffset(sprite_index),
					 y - sprite_get_yoffset(sprite_index) + 4);
}

// Draw the held item
if (inventory.belt_selection >= 0 && inventory.belt_selection < array_length_1d(inventory.belt))
{
	var balance_delta = [m_itemBalancePivot[0] - x, m_itemBalancePivot[1] - y];
	var held_item = inventory.belt[inventory.belt_selection];
	if (held_item.onUse == generalYeetableOnUse)
	{
		var item_sprite = object_get_sprite(held_item.object);
		var balance_step_x = 0.23 * balance_delta[0] + 0.4 * (sin(Time.time) + sin(Time.time * 0.74));
		var balance_step_y = (8 - balance_delta[1] * 0.1) - sqrt(abs(balance_step_x));
		for (var i = 0; i < held_item.count; ++i)
		{
			draw_sprite(item_sprite, 0,
						dx + i * balance_step_x,
						dy - z_height - 26 - i * balance_step_y);
		}
	}
}

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
}