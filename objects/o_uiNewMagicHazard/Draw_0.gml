/// @description "New magical hazard"

var blender = m_timer;

var draw_x = GameCamera.x;
var draw_y = GameCamera.y - (GameCamera.height * 0.5) + 80;

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_font(global.font_arvo9);

var kGoldColor = c_uigold;

// Perform some vertical motion
draw_y -= 80 * power(1.0 - saturate(blender), 4.0);

// Fade in the effects
var t_linePct = smoothstep(saturate(blender));
var t_gearRot = smoothstep(1.0 - saturate(blender)) * 180;
var t_textAlpha = saturate(blender);
var t_shapeAlpha = saturate(blender * 2.0);
// Fade out the effects
t_shapeAlpha *= saturate(1.0 - (blender - 3.0));
t_textAlpha *= saturate(1.0 - (blender - 3.5) * 2.0);

// Draw everything
draw_set_color(kGoldColor);
draw_set_alpha(t_textAlpha);
draw_text_spaced(draw_x, draw_y, "MAGIC HAZARD RECORDED", 3);
draw_set_alpha(t_shapeAlpha);
draw_line(draw_x - 90 * t_linePct, draw_y -  1, draw_x + 90 * t_linePct, draw_y -  1);
draw_line(draw_x - 90 * t_linePct, draw_y + 15, draw_x + 90 * t_linePct, draw_y + 15);
draw_line(draw_x - 80 * t_linePct, draw_y + 18, draw_x + 80 * t_linePct, draw_y + 18);
draw_set_alpha(1.0);
shader_set(sh_colormask);
draw_sprite_ext(sui_gearSmall, 0, draw_x - 110 * t_linePct, draw_y + 7, 1.0, 1.0, +t_gearRot, kGoldColor, t_shapeAlpha);
draw_sprite_ext(sui_gearSmall, 0, draw_x + 110 * t_linePct, draw_y + 7, 1.0, 1.0, -t_gearRot, kGoldColor, t_shapeAlpha);
shader_reset();