/// @description Constants & render init

width = 1280;
height = 720;
pixelScale = 2;

// Disable automatic app-surface drawing.
application_surface_enable(false);
application_surface_draw_enable(false);

// Set up surfaces
m_outputSurface = null;
m_gameSurface = null;

// Set up output camera
m_outputCamera = camera_create_view(0, 0, Screen.width, Screen.height);

// Set up palette system
paletteInit();

// Shader sampler info
uni_samplerPaletteLUT = shader_get_sampler_index( sh_repaletteScene, "samplerPaletteLUT" );
uni_lookupDivs = shader_get_uniform( sh_repaletteScene, "uLookupDivs" );