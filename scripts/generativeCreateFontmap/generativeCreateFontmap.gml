var font = argument0;

var width = 256;
var surface = surface_create(width, width);
var spacing = 16;

var ch_start = 32;
var ch_end = 255;

// bind and clear the surface
surface_set_target(surface);
// clear the surface
draw_clear_alpha(c_black, 1.0);

// set up the font
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(font);

var pen_x = 0;
var pen_y = 0;
for (var ch = ch_start; ch <= ch_end; ++ch)
{
	var ch_str = chr(ch);
	
	// draw the text
	draw_text(pen_x, pen_y, ch_str);
	
	// go to next line if we're past the ending
	pen_x += spacing;
	if (pen_x + spacing > width)
	{
		pen_x -= width;
		pen_y += spacing;
	}
}

// stop drawing
surface_reset_target();

// save
surface_save(surface, font_get_name(font) + ".png");

// free
surface_free(surface);