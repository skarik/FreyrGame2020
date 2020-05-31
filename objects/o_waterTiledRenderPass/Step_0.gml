/// @description Update depth and status

depth = layer_get_depth(target_layer);

if (iexists(o_waterTiledRenderPassFinal))
	o_waterTiledRenderPassFinal.depth = min(depth - 1, o_waterTiledRenderPassFinal.depth);