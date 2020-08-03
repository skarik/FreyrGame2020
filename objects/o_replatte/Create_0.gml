/// @description set up palette

if (singleton_this()) exit;

depth = -8998;
persistent = true;

// temp surface buffer
m_repaletteBuffer = null;

// Set up palette system
paletteInit();

// Shader sampler info
uni_samplerPaletteLUT = shader_get_sampler_index( sh_repaletteScene, "samplerPaletteLUT" );
uni_samplerPaletteLUTSecond = shader_get_sampler_index( sh_repaletteScene, "samplerPaletteLUTSecond" );
uni_lookupDivs = shader_get_uniform( sh_repaletteScene, "uLookupDivs" );
uni_overlayMadd2 = shader_get_uniform( sh_repaletteScene, "uOverlayMadd2" );

uni_samplerPaletteLUT_UI = shader_get_sampler_index( sh_repaletteUI, "samplerPaletteLUT" );
uni_samplerPaletteLUTSecond_UI = shader_get_sampler_index( sh_repaletteUI, "samplerPaletteLUTSecond" );
uni_lookupDivs_UI = shader_get_uniform( sh_repaletteUI, "uLookupDivs" );
uni_overlayMadd2_UI = shader_get_uniform( sh_repaletteUI, "uOverlayMadd2" );