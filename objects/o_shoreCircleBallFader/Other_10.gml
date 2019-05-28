
draw_set_color(merge_color(c_black, make_color_rgb(210, 210, 0), saturate(image_alpha)));
draw_ellipse(
	x - GameCamera.view_x - 64 * image_xscale,
	y - GameCamera.view_y - 64 * image_yscale,
	x - GameCamera.view_x + 64 * image_xscale,
	y - GameCamera.view_y + 64 * image_yscale,
	true);