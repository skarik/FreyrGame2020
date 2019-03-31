var dx, dy;
dx = round(x);
dy = round(y);

if (!inWater)
{
	gpu_set_alphatestenable(false);
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	draw_set_color(c_ltgray);
	draw_ellipse(dx - 7, dy + 5, dx + 6, dy + 9, false);

	gpu_set_blendmode(bm_normal);
	gpu_set_alphatestenable(true);
	draw_self();
}
else
{
	gpu_set_alphatestenable(false);
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	draw_set_color(c_ltgray);
	draw_ellipse(dx - 7 - 2, dy + 5 - 4 - 1, dx + 6 + 2, dy + 9 - 4 + 1, false);

	gpu_set_blendmode_ext(bm_dest_color, bm_src_color);
	draw_set_color(c_white);
	draw_ellipse(dx - 7 + 1, dy + 5 - 4, dx + 6 - 1, dy + 9 - 4, false);

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
	camPlayerDrawDebug();
	draw_set_color(c_black);
	draw_set_font(f_04b03);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(x - 4, y - 32, string(meleeAtkCurrent));
	draw_text(x + 16, y - 32, string(meleeAtkTimer));
}