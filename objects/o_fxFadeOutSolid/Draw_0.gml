var cam_xview = GameCamera.view_x;
var cam_yview = GameCamera.view_y;
var cam_wview = GameCamera.width;
var cam_hview = GameCamera.height;

gpu_set_blendenable(true);
gpu_set_blendmode(bm_normal);
draw_set_alpha(saturate(image_alpha));
draw_set_color(image_blend);
draw_rectangle(cam_xview,cam_yview,cam_xview+cam_wview,cam_yview+cam_hview,false);
draw_set_alpha(1.0);
