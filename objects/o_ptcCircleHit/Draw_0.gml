/// @description draw effect circle

shader_set(sh_dispelFadeOut);
texture_set_stage(samplerTexNoise, fadeoutNoiseTexture);
shader_set_uniform_f(uTexNoiseSize, 32, 32);
shader_set_uniform_f(uTexNoiseCoords, fadeoutNoiseCoords[0], fadeoutNoiseCoords[1], fadeoutNoiseCoords[2], fadeoutNoiseCoords[3]);
shader_set_uniform_f(uEffectiveAlpha, sqrt(abs(image_alpha)));

draw_set_color(image_blend);
draw_circle(x, y, radius - 0.2, true);
draw_circle(x, y, radius, true);
draw_circle(x, y, radius + 0.2, true);

shader_reset();
