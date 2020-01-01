
/*if (!tilled)
{
	if (!watered)
	{
		draw_sprite_part(s_field, 0, 0, 0, 16, 16, x, y);
	}
	else
	{
		draw_sprite_part(s_field, 0, 16, 0, 16, 16, x, y);
	}
}
else
{
	if (!watered)
	{
		draw_sprite_part(s_field, 0, 16, 16, 16, 16, x, y);
	}
	else
	{
		draw_sprite_part(s_field, 0, 0, 16, 16, 16, x, y);
	}
}*/

if (!tilled)
{
	draw_sprite_part(s_field, 0, watered ? 16 : 0, 16 * m_sprIndexUntilled, 16, 16, x, y);
}
else
{
	draw_sprite_part(s_field, 0, watered ? 16 : 0, 16, 16, 16, x, y);
}