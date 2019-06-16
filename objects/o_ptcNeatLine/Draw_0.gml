/// @description Draw the line

draw_set_color(image_blend);
draw_set_alpha(image_alpha);

var dlength = length;
dlength *= saturate(lerp(0.0, 8.0, life));

draw_line(
	x, y,
	x + lengthdir_x(dlength, mdirection),
	y + lengthdir_y(dlength, mdirection));

draw_set_alpha(1.0);