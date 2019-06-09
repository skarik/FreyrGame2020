gpu_set_blendenable(true);
gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);

with (ob_collider)
{
	draw_sprite_ext(
		sprite_exists(mask_index) ? mask_index : sprite_index,
		image_index,
		x, y,
		image_xscale, image_yscale, image_angle,
		c_white, 0.5);
}

with (ob_elevationArea)
{
	if (z == o_PlayerTest.z)
	{
		draw_sprite_ext(
			sprite_exists(mask_index) ? mask_index : sprite_index,
			image_index,
			x, y,
			image_xscale, image_yscale, image_angle,
			c_white, 0.5);
	}
	else
	{
		draw_sprite_ext(
			sprite_exists(mask_index) ? mask_index : sprite_index,
			image_index,
			x, y,
			image_xscale, image_yscale, image_angle,
			c_gray, 0.5);
	}
}

with (o_PlayerTest)
{
	draw_sprite_ext(
		sprite_exists(mask_index) ? mask_index : sprite_index,
		image_index,
		x, y,
		image_xscale, image_yscale, image_angle,
		c_white, 0.5);
}

with (ob_doodad)
{
	draw_set_color(c_black);
	draw_set_font(f_04b03);
	draw_set_valign(fa_top);
	draw_set_halign(fa_right);
	draw_text(x - 4, y + 4, "z: " + string(z));
	draw_set_halign(fa_left);
	draw_text(x + 4, y + 4, "z_height: " + string(z_height));
}

draw_set_alpha(1.0);
paletteDebugDisplay();