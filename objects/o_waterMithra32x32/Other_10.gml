/// @description Draw water box

//draw_circle_color(x - GameCamera.view_x, y - GameCamera.view_y, 64 * image_xscale, c_maroon, c_black, false);
draw_set_color(make_color_rgb(255, 255, 0));
draw_rectangle(x - GameCamera.view_x,
			   y - (z + 64) - GameCamera.view_y,
			   x + sprite_width - GameCamera.view_x + 1,
			   y + sprite_height - GameCamera.view_y + 1,
			   false);