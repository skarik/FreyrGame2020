/// @description create that gentle glow

var ro0 = sin(current_time * 0.0026 + id) * 2;
var ro1 = sin(current_time * 0.0048 + id) * 1;
var ro2 = sin(current_time * 0.0085 + id) * 0.7;

draw_circle_color(x + xoffset, y + yoffset, 11 + ro2,   make_color_rgb(80, 80, 80), make_color_rgb(64, 64, 64), false);

draw_circle_color(x + xoffset, y + yoffset, 80 + ro1,   merge_color(c_black, c_crystalblue, image_alpha * 0.50), c_black, false);

draw_circle_color(x + xoffset, y + yoffset, 120 + ro0,  merge_color(c_black, c_crystalblue, image_alpha * 0.35),
														merge_color(c_black, c_crystalblue, image_alpha * 0.15), false);
														
draw_circle_color(x + xoffset, y + yoffset, 280,	    merge_color(c_black, c_crystalblue, image_alpha * 0.20), c_black, false);