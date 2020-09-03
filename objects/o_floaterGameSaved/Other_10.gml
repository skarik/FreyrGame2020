draw_set_color(c_electricity);
draw_set_alpha(saturate(image_alpha));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(global.font_arvo6Bold);
draw_text_spaced(x - GameCamera.view_x,
				 y - GameCamera.view_y, 
				 "Game Saved",
				 3);
draw_set_alpha(1.0);


