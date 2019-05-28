draw_set_color(make_color_rgb(150, 180, 20));
draw_ellipse(
	x - GameCamera.view_x - 64 * image_xscale,
	y - GameCamera.view_y - 64 * image_yscale,
	x - GameCamera.view_x + 64 * image_xscale,
	y - GameCamera.view_y + 64 * image_yscale,
	false);

draw_set_color(c_white);
draw_ellipse_color(
	x - GameCamera.view_x - 64 * image_xscale,
	y - GameCamera.view_y - 64 * image_yscale,
	x - GameCamera.view_x + 64 * image_xscale,
	y - GameCamera.view_y + 64 * image_yscale,
	make_color_rgb(60, 255, 0),
	c_black,
	false);
