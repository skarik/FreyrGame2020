/// @description draw effect line

var ux = lengthdir_x(1.0, image_angle);
var uy = lengthdir_y(1.0, image_angle);

shader_set(sh_dispelFadeOut);

texture_set_stage(samplerTexNoise, fadeoutNoiseTexture);
shader_set_uniform_f(uTexNoiseSize, 32 / 2, 32 / 2);
shader_set_uniform_f(uTexNoiseCoords, fadeoutNoiseCoords[0], fadeoutNoiseCoords[1], fadeoutNoiseCoords[2], fadeoutNoiseCoords[3]);
shader_set_uniform_f(uEffectiveAlpha, abs(image_alpha));

draw_set_color(image_blend);
draw_line(x, y, x + ux * lx_pos_size, y + uy * lx_pos_size);
draw_line(x, y, x - ux * lx_neg_size, y - uy * lx_neg_size);
draw_line(x, y, x - uy * ly_pos_size, y + ux * ly_pos_size);
draw_line(x, y, x + uy * ly_neg_size, y - ux * ly_neg_size);

shader_reset();
