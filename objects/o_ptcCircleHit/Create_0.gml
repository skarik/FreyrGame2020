/// @description variables

radius = 2;
growSpeed = 200;
slowAccel = growSpeed * 3;

fadePoint = growSpeed * 0.9;
fadeSpeed = 5;


fadeoutNoiseTexture = sprite_get_texture(s_effectNoise, 0);
fadeoutNoiseCoords = sprite_get_uvs(s_effectNoise, 0);
samplerTexNoise = shader_get_sampler_index(sh_dispelFadeOut, "samplerTexNoise");
uTexNoiseSize = shader_get_uniform(sh_dispelFadeOut, "uTexNoiseSize");
uTexNoiseCoords = shader_get_uniform(sh_dispelFadeOut, "uTexNoiseCoords");
uEffectiveAlpha = shader_get_uniform(sh_dispelFadeOut, "uEffectiveAlpha");