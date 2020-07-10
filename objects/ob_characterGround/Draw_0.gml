/// @description draw with depth (esp if in water)
var dx, dy;
dx = round(x);
dy = round(y);

if (!inWater || z_height > 1)
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
	draw_sprite_ext(sprite_index, image_index,
					dx, round(dy - z_height + moAnimationYOffset),
					image_xscale, image_yscale,
					image_angle,
					image_blend,
					image_alpha);
}
else
{	// Draw in water
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