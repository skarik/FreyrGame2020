/// @description Draw the glow here
				
// Draw power line
if (visual_power > 0.0)
{
	draw_set_color(merge_color(c_towerdiamond, c_white, saturate(overcharge)));
	draw_rectangle(x - visual_power * 3.0 + xoffset, y + 2 + yoffset,
				   x + 1 + visual_power * 2.0 + xoffset, y - 16 * 2.5 - 1 + yoffset,
				   false);
}

// Draw front bits
gpu_set_blendmode(bm_normal);
draw_sprite_ext(sprite_index, image_index + 1,
				x, y, image_xscale, image_yscale, image_angle, c_black, image_alpha); // TODO: properly mask it
				
// Draw the lighting
lightingResetBlendMode();
				
draw_set_alpha(1.0);
draw_set_color(merge_color(c_black, c_towercrystal, 0.2 * visual_power));
draw_circle(x + xoffset, y + yoffset, 30 + 40 * visual_power, false);
draw_circle_color(x + xoffset, y + yoffset,
				  50 + 50 * visual_power,
				  merge_color(c_black, c_towercrystal, 0.1 * visual_power),
				  c_black,
				  false);
				  
// Draw overcharge glow
if (overcharge > 0.0)
{
	//draw_set_color(merge_color(c_black, c_towerdiamond, saturate(overcharge) * 0.05));
	draw_circle_color(x + xoffset, y + yoffset,
				  50 + 100 * overcharge,
				  merge_color(c_black, c_towerdiamond, saturate(overcharge) * 0.05),
				  c_black,
				  false);
	draw_sprite_ext(sprite_index, image_index + 1,
					x, y, image_xscale, image_yscale, image_angle,
					c_black, saturate(overcharge) * 0.5);
}