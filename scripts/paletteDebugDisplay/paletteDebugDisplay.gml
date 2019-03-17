for (var i = 0; i < global.pal_width; ++i)
{
	draw_set_color(global.pal_color[i]);
	draw_rectangle(i * 8, 0, i * 8 + 8, 8, false);
}
draw_sprite(global.pal_sprite3d, 0, 0, 8);

/*
for (var u = 0; u < global.pal_lutWidth; ++u)
{
	for (var v = 0; v < global.pal_lutWidth; ++v)
	{
		for (var w = 0; w < global.pal_lutWidth; ++w)
		{
			var i3d = (u) + (v * global.pal_lutWidth) + (w * global.pal_lutWidth * global.pal_lutWidth);
			draw_set_color(global.pal_lut[i3d]);
			draw_point(
				u + (w % 8) * global.pal_lutWidth,
				v + floor(w / 8) * global.pal_lutWidth + 8);
		}
	}
}*/