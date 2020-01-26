/// @description Open/close

event_inherited();

depthUpdate();
depth += lengthdir_y(-16, image_angle);

if (m_powerInput > 0.5 || m_powerOutput > 0.5)
{
	m_openBlend = saturate(m_openBlend + 0.7 * Time.deltaTime);
	m_glowPower = saturate(m_glowPower + 4.0 * Time.deltaTime);
	
	m_glowAlpha = saturate(m_glowPower + (random(0.2) - 0.1));
	
	instance_deactivate_object(m_collider);
}
else
{
	m_openBlend = saturate(m_openBlend - 1.5 * Time.deltaTime);
	m_glowPower = saturate(m_glowPower - 4.0 * Time.deltaTime);
	m_glowAlpha = saturate(m_glowAlpha - 1.0 * Time.deltaTime);
	
	instance_activate_object(m_collider);
}

var width = sprite_get_width(sprite_index);
m_light.x = x + lengthdir_x(width, image_angle) * image_xscale;
m_light.y = y + lengthdir_y(width, image_angle) - 16;
m_light.image_alpha = m_glowAlpha * 0.5;

image_angle = smoothstep(m_openBlend) * 75.0;