/// @description draw additive explosion

gpu_set_blendenable(true);
gpu_set_blendmode(bm_add);
draw_set_alpha(saturate(alpha));
draw_set_color(color);
draw_circle(x, y, radius, false);
draw_circle(x, y, radius * 0.75, false);
draw_circle(x, y, radius * 0.5, false);
draw_set_alpha(1.0);
gpu_set_blendmode(bm_normal);