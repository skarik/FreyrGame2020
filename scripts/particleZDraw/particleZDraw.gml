var dx, dy;
dx = round(x);
dy = round(y);
var shadow_pct = max(0.5, sprite_height / 32.0);
shadow_pct /= (1.0 + max(0.0, z_height) / 32.0);
shadow_pct *= min(1.0, max(0.0, z_height) / 4.0);
var shadow_w = shadow_pct * 6.0;
var shadow_h = shadow_pct * 2.0;

gpu_set_alphatestenable(false);
gpu_set_blendenable(true);
gpu_set_blendmode_ext(bm_dest_color, bm_zero);
draw_set_color(c_ltgray);
draw_ellipse(floor(dx - 1 - shadow_w), floor(dy - 1 - shadow_h), ceil(dx + shadow_w), ceil(dy + shadow_h), false);

gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);
draw_sprite_ext(sprite_index, image_index,
				dx, round(dy - z_height),
				image_xscale, image_yscale,
				image_angle,
				image_blend,
				image_alpha);