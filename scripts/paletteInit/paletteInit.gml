// need to create a list of all the colors first
#macro kPaletteCrushed 0
#macro kPaletteWide 1

global.pal_sourceCrushed = s_paletteCrushed;
global.pal_sourceWide = s_paletteWide;
//global.pal_sprite3d = null;
//global.pal_sprite3d2 = null;

_paletteLoad(kPaletteCrushed, global.pal_sourceCrushed);
_paletteLoad(kPaletteWide, global.pal_sourceWide);

// clear out surfaces
global.pal_surface3d = null;
global.pal_surface3d2 = null;

// Set up overlay values
global.pal_overlay_madd2 = make_color_rgb(128,128,128);

// Set current palette
global.pal_current = kPaletteCrushed;
global.pal_current_blend = 0.0;