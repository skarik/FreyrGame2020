var pct;

var cam_xview = GameCamera.view_x;
var cam_yview = GameCamera.view_y;
var cam_wview = GameCamera.width;
var cam_hview = GameCamera.height;

pct = clamp(image_alpha * 4.0 - 0.0, 0.0, 1.0);
gpu_set_blendenable(true);
gpu_set_blendmode_ext(bm_zero, bm_dest_colour);
draw_rectangle(cam_xview,cam_yview,cam_xview+cam_wview,cam_yview+cam_hview*pct,false);

pct = clamp(image_alpha * 4.0 - 1.0, 0.0, 1.0);
gpu_set_blendmode_ext(bm_zero, bm_src_colour);
draw_set_color(c_gray);
draw_rectangle(cam_xview,cam_yview,cam_xview+cam_wview,cam_yview+cam_hview*pct,false);

pct = clamp(image_alpha * 4.0 - 2.0, 0.0, 1.0);
gpu_set_blendmode_ext(bm_zero, bm_src_colour);
draw_set_color(c_gray);
draw_rectangle(cam_xview,cam_yview,cam_xview+cam_wview,cam_yview+cam_hview*pct,false);

pct = clamp(image_alpha * 4.0 - 3.0, 0.0, 1.0);
gpu_set_blendmode(bm_normal);
draw_set_color(c_black);
draw_set_alpha(1.0);
draw_rectangle(cam_xview,cam_yview,cam_xview+cam_wview,cam_yview+cam_hview*pct,false);

gpu_set_blendmode(bm_normal);