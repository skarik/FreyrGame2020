// need to create a list of all the colors first

global.pal_defaultSource = s_paletteDefault;

var palette_width = sprite_get_width(global.pal_defaultSource);

var palette_surface = surface_create(palette_width, 1);
surface_set_target(palette_surface);
draw_sprite(global.pal_defaultSource, 0, 0, 0);
surface_reset_target();

var palette_buffer = buffer_create(palette_width * 4, buffer_fixed, 4); 
buffer_get_surface(palette_buffer, palette_surface, buffer_surface_copy, 0, 0);

for (var i = 0; i < palette_width; ++i)
{
	var _col = buffer_read(palette_buffer, buffer_u32); 
    var _a = (_col >> 24) & 255;
    var _b = (_col >> 16) & 255;
    var _g = (_col >> 8) & 255;
    var _r = _col & 255;  
    var _col = make_color_rgb(_r, _g, _b);
	
	global.pal_color[i] = _col;
}
global.pal_width = palette_width;

buffer_delete(palette_buffer);
surface_free(palette_surface);

// Now, generate a 3d LUT
global.pal_granularity = 8;
global.pal_lutWidth = 256 / global.pal_granularity;
for (var u = 0; u < global.pal_lutWidth; ++u)
{
	for (var v = 0; v < global.pal_lutWidth; ++v)
	{
		for (var w = 0; w < global.pal_lutWidth; ++w)
		{
			var i3d = (u) + (v * global.pal_lutWidth) + (w * global.pal_lutWidth * global.pal_lutWidth);
			
			// find the closest color
			var _delta = 256 * 256 * 3;
			var _color = c_black;
			for (var i = 0; i < palette_width; ++i)
			{
				var _r = u * global.pal_granularity + global.pal_granularity / 2;
				var _g = v * global.pal_granularity + global.pal_granularity / 2;
				var _b = w * global.pal_granularity + global.pal_granularity / 2;
				//var _rgb = make_color_rgb(_r, _g, _b);	
				var _deltaTest = sqr(color_get_red(global.pal_color[i]) - _r)
					+ sqr(color_get_green(global.pal_color[i]) - _g)
					+ sqr(color_get_blue(global.pal_color[i]) - _b);
				//var _deltaTest = sqr(color_get_value(global.pal_color[i]) - color_get_value(_rgb)) * 2.0
				//	+ sqr(color_get_saturation(global.pal_color[i]) - color_get_saturation(_rgb)) * 0.0125
				//	+ sqr(angle_difference(color_get_hue(global.pal_color[i]) / 255.0 * 360, color_get_hue(_rgb)  / 255.0 * 360) * (360.0 / 255)) * 0.015;
					
				if (_deltaTest < _delta)
				{
					_delta = _deltaTest;
					_color = global.pal_color[i];
				}
			}
			
			global.pal_lut[i3d] = _color;
		}
	}
}

// Now, create a texture from the 3d LUT
global.pal_lutSplit = 1;
var palette_surface3d = surface_create(global.pal_lutWidth * global.pal_lutWidth / global.pal_lutSplit, global.pal_lutWidth * global.pal_lutSplit);
var palette_divLut = global.pal_lutWidth / global.pal_lutSplit;

surface_set_target(palette_surface3d);
draw_set_alpha(1.0);

for (var u = 0; u < global.pal_lutWidth; ++u)
{
	for (var v = 0; v < global.pal_lutWidth; ++v)
	{
		for (var w = 0; w < global.pal_lutWidth; ++w)
		{
			var i3d = (u) + (v * global.pal_lutWidth) + (w * global.pal_lutWidth * global.pal_lutWidth);
			draw_set_color(global.pal_lut[i3d]);
			draw_point(
				u + (w % palette_divLut) * global.pal_lutWidth,
				v + floor(w / palette_divLut) * global.pal_lutWidth);
		}
	}
}

surface_reset_target();


global.pal_sprite3d = sprite_create_from_surface(palette_surface3d, 0, 0, surface_get_width(palette_surface3d), surface_get_height(palette_surface3d), false, false, 0, 0);
global.pal_surface3d = palette_surface3d;

//surface_free(palette_surface3d);

// Set up overlay values
global.pal_overlay_madd2 = make_color_rgb(128,128,128);