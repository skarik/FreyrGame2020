/// @description draw node & all links

draw_sprite(ssy_node, 0, x, y);
draw_set_color(c_yellow);
var links_count = array_length_1d(m_link);
for (var i = 0; i < links_count; ++i)
{
	draw_line(x, y, m_link[i].x, m_link[i].y);
}