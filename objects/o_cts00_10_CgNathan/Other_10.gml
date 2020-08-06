/// @description Draw scene in screenspace

var t_alpha = saturate(time * 4.0);
var t_backgroundY = lerp(20, -20, sqrt(saturate(time / 1.5)));   // 360 total, with 20 from bottom & 20 from top
var t_backgroundX = lerp(-40, 0, smoothstep(saturate((time - 1.5) / 2.0)));

// draw the background
draw_sprite_ext(sui_cg00_nathan_bg, 0, t_backgroundX, t_backgroundY, 1.0, 1.0, 0.0, c_white, t_alpha);

// draw bars over that
draw_set_color(c_black);
draw_set_alpha(1.0);
draw_rectangle(0, 0, GameCamera.width, kCutsceneBarWidth, false);
draw_rectangle(0, GameCamera.height - kCutsceneBarWidth, GameCamera.width, GameCamera.height, false);

// draw nathan over that
draw_sprite_ext(sui_cg00_nathan_char, 0, -t_backgroundX * 0.2, 0, 1.0, 1.0, 0.0, c_white, t_alpha);