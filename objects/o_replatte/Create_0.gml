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