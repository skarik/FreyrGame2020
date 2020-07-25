/// @description Reset depth & declares vars

if (instance_number(object_index) > 1) 
{
	idelete(this);
	exit;
}

depth = 60;
persistent = false;

// Surface used for rendering the farmland
m_surface = null;
m_surfacePeturb = null;

// Shader sampler info
uni_samplerPaletteLUT = shader_get_sampler_index( sh_metaballFarmland, "samplerPaletteLUT" );
uni_paletteAtlasCoords = shader_get_uniform( sh_metaballFarmland, "uPaletteAtlasCoords" );
uni_waterTexelSize = shader_get_uniform( sh_metaballFarmland, "uWaterTexelSize" );
uni_currentTime = shader_get_uniform( sh_metaballFarmland, "uCurrentTime" );
uni_samplerPeturb = shader_get_sampler_index( sh_metaballFarmland, "samplerPeturb" );