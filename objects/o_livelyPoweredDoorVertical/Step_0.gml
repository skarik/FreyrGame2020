/// @description Override angle

// Inherit the parent event
event_inherited();

if (!m_doorVerticalFlip)
{
	image_angle = 270.0 + smoothstep(m_openBlend) * 75.0;
	m_collider.image_angle = image_angle * image_xscale;
}
else
{
	image_angle = 90.0 - smoothstep(m_openBlend) * 75.0;
	m_collider.image_angle = image_angle * image_xscale;
}