if (draw_visible)
{
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_src_alpha, bm_inv_src_alpha);

	with (ob_colliderNoDepth)
	{
		draw_sprite_ext(
			sprite_exists(mask_index) ? mask_index : sprite_index,
			image_index,
			x, y,
			image_xscale, image_yscale, image_angle,
			c_white, 0.5);
	}
	with (ob_colliderDepth)
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

	draw_set_color(c_black);
	draw_set_font(f_04b03);
	with (ob_doodad)
	{
		draw_set_valign(fa_top);
		draw_set_halign(fa_right);
		draw_text(x - 4, y + 4, "z: " + string(z));
		draw_set_halign(fa_left);
		draw_text(x + 4, y + 4, "z_height: " + string(z_height));
	}
	with (ob_colliderDepth)
	{
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		draw_text(x, y, "z: " + string(z));
	}

	draw_set_alpha(1.0);
	paletteDebugDisplay();

	// draw the cameras
	draw_set_color(c_lime);
	with (GameCamera)
	{
		draw_rectangle(
			view_x + 8,
			view_y + 8,
			view_x + width - 8,
			view_y + height - 8,
			true);
	}
}

if (recordModeEnabled)
{
	with (GameCamera)
	{
		var kGifUpscale = 2.0;
		var kGifWidth = 560; //Screen.width / Screen.pixelScale;
		var kGifHeight = 560; //Screen.height / Screen.pixelScale; 
		
		draw_set_color(c_lime);
		draw_rectangle(
			view_x + width * 0.5 - (kGifWidth/kGifUpscale * 0.5) - 4,
			view_y + height * 0.5  - (kGifHeight/kGifUpscale * 0.5) - 4,
			view_x + width * 0.5 + (kGifWidth/kGifUpscale * 0.5) + 4,
			view_y + height * 0.5 + (kGifHeight/kGifUpscale * 0.5) + 4,
			true);
	}
}