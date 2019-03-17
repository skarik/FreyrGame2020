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

with (o_PlayerTest)
{
	draw_sprite_ext(
		sprite_exists(mask_index) ? mask_index : sprite_index,
		image_index,
		x, y,
		image_xscale, image_yscale, image_angle,
		c_white, 0.5);
}

draw_set_alpha(1.0);
paletteDebugDisplay();