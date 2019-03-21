if (m_isSource)
{
	draw_self();
	draw_set_color(c_blue);
	draw_rectangle(x, y, x + 15, y + 15, true);
}
else
{
	if (m_waterLevel > 0)
	{
		draw_set_color(c_blue);
		draw_rectangle(x, y, x + 15, y + 15, true);
	}
	else
	{
		draw_self();
	}
}