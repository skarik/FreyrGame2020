/// @description Init

target_layer = null;
target_tilemap = null;




// Shader sampler info
uni_samplerPaletteLUT = shader_get_sampler_index( sh_metaballWater2, "samplerPaletteLUT" );
uni_paletteAtlasCoords = shader_get_uniform( sh_metaballWater2, "uPaletteAtlasCoords" );
uni_waterTexelSize = shader_get_uniform( sh_metaballWater2, "uWaterTexelSize" );
uni_currentTime = shader_get_uniform( sh_metaballWater2, "uCurrentTime" );
uni_samplerPeturb = shader_get_sampler_index( sh_metaballWater2, "samplerPeturb" );

/*
uni_samplerWaterMask = shader_get_sampler_index( sh_waterReflectRender, "samplerWaterMask" );
uni_samplerDepthHack = shader_get_sampler_index( sh_waterReflectRender, "samplerDepthHack" );
uni_currentTimeReflection = shader_get_uniform( sh_waterReflectRender, "uCurrentTime");
uni_viewOffset = shader_get_uniform( sh_waterReflectRender, "uViewOffset" );*/

if (!iexists(o_waterTiledRenderPassFinal))
{
	inew(o_waterTiledRenderPassFinal);
}