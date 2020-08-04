/// @description start up the darkNESS

if (singleton_this()) exit;

depth = -8999;
persistent = true;

m_darkness = null;
m_bloom = null;
//m_bloom2 = null;
m_compositingBuffer = null;

uni_pixelOffset = shader_get_uniform( sh_shadowBanding, "u_pixelOffset" );
uni_pixelSize = shader_get_uniform( sh_9tapBlur, "uPixelSize" );
uni_bloomParams = shader_get_uniform( sh_bloomDrop, "uBloomParams" );

bloom_drop = 0.0;
bloom_mul = 0.0;

uPixelOffset = shader_get_uniform( sh_lightingComposite, "uPixelOffset" );
uBloomParams = shader_get_uniform( sh_lightingComposite, "uBloomParams" );

samplerDynamicLights = shader_get_sampler_index( sh_lightingComposite, "samplerDynamicLights" );
samplerBloom = shader_get_sampler_index( sh_lightingComposite, "samplerBloom" );