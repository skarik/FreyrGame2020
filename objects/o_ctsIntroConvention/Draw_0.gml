/// @description draw visuals

draw_set_color(c_white);
draw_rectangle(0, 0, 640, 640, false);

shader_set(sh_colormask);
draw_sprite_ext(sui_logo2, 0, x, round(y + 24 + sin(current_time * 0.0015) * 9.4), 1.0, 1.0, 0.0, c_dkgray, 0.3);
shader_reset();

// draw text
draw_set_color(c_black);
draw_set_alpha(sin(current_time * 0.0012) * 0.25 + 0.7);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(f_arvo9Bold);
draw_text(x, y + 25, "FREE   DEMO\nGAME   IN   DEVELOPMENT");
draw_set_font(f_04b03);
draw_text(x, y + 100, "Press Any Button");
draw_set_alpha(1.0);

// draw the black overlay
gpu_set_blendmode_ext(bm_dest_color, bm_zero);
draw_rectangle_color(0, 360 + y, 640, 360 + 1000 + y, c_white, c_white, c_black, c_black, false);
draw_set_color(c_black);
draw_rectangle(0, 360 + 1000 + y, 640, 360 + 4000 + y, false);
gpu_set_blendmode(bm_normal);