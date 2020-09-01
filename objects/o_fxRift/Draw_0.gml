/// @description Draw effect (forward to unified draw)

xoffset = 0;
yoffset = 0;
event_user(kEvent_UnifiedDraw6);

var dx = x;
var dy = y - z_height;
var radius = 30.0 * image_xscale;

// Draw the waterfall
{
	// Save positions for sanity's sake
	var x0 = dx - 4;
	var x1 = dx + 4;
	var y0 = dy + radius - 1;
	var y1 = y - 8;
	
	draw_set_alpha(0.25);
	draw_set_color(make_color_rgb(60, 159, 156));
	draw_rectangle(x0, y0, x1, y1, false);
	draw_rectangle(lerp(x0, x1, 0.125), y0, lerp(x0, x1, 0.875), y1 + 1, false);
	draw_rectangle(lerp(x0, x1, 0.300), y0, lerp(x0, x1, 0.700), y1 + 2, false);
	
	draw_set_alpha(0.5);
	draw_set_color(make_color_rgb(116, 186, 234)); 
	draw_line(x0 + 1, y1 - 8 + 8 * sin(Time.time *  4.323), x0 + 1, y1 - 32 - 8 * sin(Time.time *  5.123) - 8 + 8 * cos(Time.time *  4.453) );
	draw_line(x0 + 7, y1 - 8 + 8 * cos(Time.time *  4.763), x0 + 7, y1 - 32 - 8 * cos(Time.time *  4.223) - 8 + 8 * sin(Time.time *  5.984) );
	draw_set_color(c_white);
	draw_line(x0 + 3, y1 - 8 + 8 * cos(Time.time *  5.235), x0 + 3, y1 - 48 - 8 * sin(Time.time *  4.763) - 8 + 8 * sin(Time.time *  4.234) );
	draw_line(x0 + 5, y1 - 8 + 8 * sin(Time.time *  5.734), x0 + 5, y1 - 48 - 8 * cos(Time.time *  4.553) - 8 + 8 * cos(Time.time *  4.945) );
	
	draw_set_alpha(1.0);
}