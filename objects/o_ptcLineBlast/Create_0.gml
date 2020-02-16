/// @description set up initial states

lx_pos_size = 0.0;
lx_neg_size = 0.0;
ly_pos_size = 0.0;
ly_neg_size = 0.0;

lx_pos_growSpeed = 30.0;
lx_neg_growSpeed = 10.0;
ly_pos_growSpeed = 1.0;
ly_neg_growSpeed = 1.0;

lx_pos_growSlow = 0.0;
lx_neg_growSlow = 0.0;
ly_pos_growSlow = 0.0;
ly_neg_growSlow = 0.0;

fadeLife = 0.0;
fadePoint = 0.4;
fadeSpeed = 5.0;

fadeoutNoiseTexture = sprite_get_texture(s_waterOverlayCaustic, 0);//s_effectNoise, 0);
fadeoutNoiseCoords = sprite_get_uvs(s_waterOverlayCaustic, 0);//s_effectNoise, 0);
samplerTexNoise = shader_get_sampler_index(sh_dispelFadeOut, "samplerTexNoise");
uTexNoiseSize = shader_get_uniform(sh_dispelFadeOut, "uTexNoiseSize");
uTexNoiseCoords = shader_get_uniform(sh_dispelFadeOut, "uTexNoiseCoords");
uEffectiveAlpha = shader_get_uniform(sh_dispelFadeOut, "uEffectiveAlpha");