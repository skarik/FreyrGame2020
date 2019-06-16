/// @description Update surfaces

if (!surface_exists(surface_shine_bg))
{
	surface_shine_bg = surface_create(display_width - 4, display_height - 4);
}

surface_set_target(surface_shine_bg);
draw_clear_alpha(c_black, 0.0);

draw_set_color(c_white);

var shineY = 0;
var shineWidth = 100;

//shineY = ((itemtrigger_shine_time * 900 + 700) % 2000) - 1000;
shineY = ((min(itemtrigger_shine_time, 4.0) * 900) % 2000) - 1000;
shineWidth = 100 * abs(500 - abs(shineY)) / 500.0;
draw_triangle(-100, shineY - 100,
				display_width + 40, shineY + 200 + shineWidth,
				display_width + 40, shineY + 200 - shineWidth,
				false);

surface_reset_target();