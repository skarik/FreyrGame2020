/// @description draw debug shapes for the door

// draw back wall: red
draw_set_color(c_red);
draw_rectangle(x - 5, y,
			   x + 5, y - 16 * 3,
			   false);

// draw the top of the door: purple
draw_set_color(make_color_rgb(255, 0, 255));
draw_rectangle(x - 4, y + sprite_height,
			   x + 4, y - (16 * 3 - 1) * (1.0 - m_openBlend),
			   false);