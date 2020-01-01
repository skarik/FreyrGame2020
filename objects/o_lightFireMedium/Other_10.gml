/// @description draw fire light

var ro0 = sin(current_time * 0.003 + id) * 5;
var ro1 = sin(current_time * 0.007 + id) * 2;
var ro2 = sin(current_time * 0.025 + id) * 1.2;

/*draw_circle_color(x + xoffset, y + yoffset, 130 + ro0, merge_color(c_gold, c_black, 0.7), c_black, false);
draw_circle_color(x + xoffset, y + yoffset, 80 + ro1, merge_color(c_yellow, c_black, 0.3), c_black, false);
draw_circle_color(x + xoffset, y + yoffset, 14 + ro2, c_gray, c_gray, false);*/

draw_circle_color(x + xoffset, y + yoffset, 130 + ro0, merge_color(c_gold, c_black, 0.35), c_black, false);
draw_circle_color(x + xoffset, y + yoffset, 80 + ro1, merge_color(c_yellow, c_black, 0.15), c_black, false);
draw_circle_color(x + xoffset, y + yoffset, 14 + ro2, c_white, c_ltgray, false);

// use x + xoffset and y + yoffset
// default blend mode is gpu_set_blendmode_ext(bm_src_alpha, bm_one);