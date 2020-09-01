uni_paletteAtlasCoords = shader_get_uniform( sh_rift, "uPaletteAtlasCoords" );
uni_currentTime = shader_get_uniform( sh_rift, "uCurrentTime" );

depthInit();

emissive = instance_create_depth(x, y, depth, o_lightEmissiveDepth_User5);
emissive.target = id;

splash_ptime = 0.0;