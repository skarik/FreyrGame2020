/*if (m_isSource)
{
	draw_self();
	draw_set_color(c_navy);
	draw_rectangle(x, y, x + 15, y + 15, true);
}
else
{
	if (m_waterLevel > 0)
	{
		draw_set_color(c_navy);
		draw_rectangle(x, y, x + 15, y + 15, true);
	}
	else
	{
		draw_self();
	}
}*/

var canalSprite = s_waterTrench;
if (m_isSource || m_waterLevel > 0)
{
	canalSprite = s_waterTrenchF;
}

draw_sprite(canalSprite, 2, x + 4, y + 8);
draw_sprite(canalSprite, 2, x + 12, y + 8);