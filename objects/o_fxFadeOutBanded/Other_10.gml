var pct;

var cam_xview = 0;//GameCamera.view_x;
var cam_yview = -1;//GameCamera.view_y - 1;
var cam_wview = GameCamera.width;
var cam_hview = GameCamera.height + 2;

gpu_set_blendenable(true);

pct = clamp(image_alpha * 4.0 - 0.0, 0.0, 1.0);
draw_set_alpha(0.4);
gpu_set_blendmode(bm_normal);
draw_set_color(image_blend);
/*if (image_blend == c_black) {
	gpu_set_blendmode_ext(bm_zero, bm_dest_colour);
}
else if (image_blend == c_white) {
	draw_set_color(c_white);
	gpu_set_blendmode_ext(bm_dest_colour, bm_src_colour);
}*/
draw_rectangle(cam_xview,cam_yview,cam_xview+cam_wview,cam_yview+cam_hview*pct,false);

pct = clamp(image_alpha * 4.0 - 1.0, 0.0, 1.0);
gpu_set_blendmode(bm_normal);
/*if (image_blend == c_black) {
	gpu_set_blendmode_ext(bm_zero, bm_src_colour);
	draw_set_color(c_gray);
}
else if (image_blend == c_white) {
	draw_set_color(c_dkgray);
	gpu_set_blendmode_ext(bm_one, bm_one);
}*/
draw_rectangle(cam_xview,cam_yview,cam_xview+cam_wview,cam_yview+cam_hview*pct,false);

pct = clamp(image_alpha * 4.0 - 2.0, 0.0, 1.0);
gpu_set_blendmode(bm_normal);
/*
if (image_blend == c_black) {
	gpu_set_blendmode_ext(bm_zero, bm_src_colour);
	draw_set_color(c_gray);
}
else if (image_blend == c_white) {
	draw_set_color(c_dkgray);
	gpu_set_blendmode_ext(bm_one, bm_one);
}*/
draw_rectangle(cam_xview,cam_yview,cam_xview+cam_wview,cam_yview+cam_hview*pct,false);

pct = clamp(image_alpha * 4.0 - 3.0, 0.0, 1.0);
gpu_set_blendmode(bm_normal);
draw_set_color(image_blend);
draw_set_alpha(1.0);
draw_rectangle(cam_xview,cam_yview,cam_xview+cam_wview,cam_yview+cam_hview*pct,false);

gpu_set_blendmode(bm_normal);