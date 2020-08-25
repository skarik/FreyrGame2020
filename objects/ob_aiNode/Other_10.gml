/// @description draw node & all links

if (point_on_camera_wide(x, y, 64, 64))
{
	draw_sprite(ssy_node, 0, x, y);
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	var links_count = array_length_1d(m_link);
	for (var i = 0; i < links_count; ++i)
	{
		draw_line(x, y, m_link[i].x, m_link[i].y);
	}
	draw_set_font(f_04b03);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(x + 8, y + 8, string(links_count));
}