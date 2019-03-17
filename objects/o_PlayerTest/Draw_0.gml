var dx, dy;
dx = round(x);
dy = round(y);

gpu_set_alphatestenable(false);
gpu_set_blendenable(true);
gpu_set_blendmode_ext(bm_dest_color, bm_zero);
draw_set_color(c_ltgray);
draw_ellipse(dx - 9, dy + 1, dx + 7, dy + 9, false);

gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);
draw_self();

if (Debug.visible)
{
	camPlayerDrawDebug();
}