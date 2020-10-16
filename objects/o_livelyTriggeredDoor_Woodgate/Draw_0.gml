/// @description Draw door

draw_self();

if (surface_exists(target_buffer))
{
	var y_offset = 0;
	if (m_wantsOpen)
		y_offset -= smoothstep(m_openBlend) * kGateTravel;
	else
		y_offset -= (1.0 - sqr(1.0 - m_openBlend)) * kGateTravel;
	
	draw_surface(target_buffer, x + target_worldoffset[0], y + target_worldoffset[1] + y_offset);
}