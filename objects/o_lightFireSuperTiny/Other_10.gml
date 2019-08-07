/// @description draw fire light

var ro0 = sin(current_time * 0.003 + id) * 2;
var ro1 = sin(current_time * 0.007 + id) * 1;
var ro2 = sin(current_time * 0.025 + id) * 0.7;

draw_circle_color(x + xoffset, y + yoffset, (70 + ro0) * 0.5, merge_color(c_gold, c_black, 0.8), c_black, false);
draw_circle_color(x + xoffset, y + yoffset, (40 + ro1) * 0.5, merge_color(c_yellow, c_black, 0.5), c_black, false);
draw_circle_color(x + xoffset, y + yoffset, (8 + ro2) * 0.5, c_gray, c_gray, false);

// use x + xoffset and y + yoffset
// default blend mode is gpu_set_blendmode_ext(bm_src_alpha, bm_one);