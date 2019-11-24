var dx, dy;
dx = round(x);
dy = round(y);

if (Debug.visible)
{
	draw_set_color(c_lime);
	draw_line(x, y - z_height, x, y);
	draw_circle(x, y, 3, false);
}

if (!inWater || z_height > 1)
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

if (Debug.visible)
{
	with (camera)
	{
		camPlayerDrawDebug();
	}
	draw_set_color(c_black);
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
}