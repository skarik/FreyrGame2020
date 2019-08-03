/// @description Reset depth & declares vars

if (instance_number(object_index) > 1) 
{
	delete(this);
	exit;
}

depth = 10;
persistent = true;

// Surface used for metaballs
m_surface = null;
m_surfacePeturb = null; // Surface used for water peturbing

// Surface used for reflections
m_surfaceReflect = null;
m_surfaceReflect_Temp = null;
m_surfaceDepthHack = null;

// Shader sampler info
uni_samplerPaletteLUT = shader_get_sampler_index( sh_metaballWater, "samplerPaletteLUT" );
uni_paletteAtlasCoords = shader_get_uniform( sh_metaballWater, "uPaletteAtlasCoords" );
uni_waterTexelSize = shader_get_uniform( sh_metaballWater, "uWaterTexelSize" );
uni_currentTime = shader_get_uniform( sh_metaballWater, "uCurrentTime" );
uni_samplerPeturb = shader_get_sampler_index( sh_metaballWater, "samplerPeturb" );

uni_samplerWaterMask = shader_get_sampler_index( sh_waterReflectRender, "samplerWaterMask" );
uni_samplerDepthHack = shader_get_sampler_index( sh_waterReflectRender, "samplerDepthHack" );
uni_currentTimeReflection = shader_get_uniform( sh_waterReflectRender, "uCurrentTime");
uni_viewOffset = shader_get_uniform( sh_waterReflectRender, "uViewOffset" );