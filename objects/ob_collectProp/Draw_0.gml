/// @description Draw the collectible

if (m_hasWiggle)
{
	shadow_enabled = m_hasShadow;
	event_perform_object(ob_doodadTreeWiggle, ev_draw, 0);
}
else if (m_hasShadow)
{
	event_perform_object(ob_doodad, ev_draw, 0);
}
else
{
	draw_self();
}