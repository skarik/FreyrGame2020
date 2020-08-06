/// @description Draw scene in screenspace

var t_alpha = saturate(time * 4.0);

// draw the background
draw_sprite_ext(sui_cg00_nathan_bg, 0, 0, 0, 1.0, 1.0, 0.0, c_white, t_alpha);

// draw bars over that
draw_set_color(c_black);
draw_set_alpha(1.0);
draw_rectangle(0, 0, GameCamera.width, kCutsceneBarWidth, false);
draw_rectangle(0, GameCamera.height - kCutsceneBarWidth, GameCamera.width, GameCamera.height, false);

// draw nathan over that
draw_sprite_ext(sui_cg00_nathan_char, 0, 0, 0, 1.0, 1.0, 0.0, c_white, t_alpha);