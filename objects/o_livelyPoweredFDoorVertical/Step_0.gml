/// @description Open/close

event_inherited();

depthUpdate();

if (m_powerInput > 0.5)
{
	m_openBlend = saturate(m_openBlend + 0.7 * Time.deltaTime);
	/*m_glowPower = saturate(m_glowPower + 4.0 * Time.deltaTime);
	
	m_glowAlpha = saturate(m_glowPower + (random(0.2) - 0.1));*/
	
	instance_deactivate_object(m_collider);
}
else
{
	m_openBlend = saturate(m_openBlend - 1.5 * Time.deltaTime);
	/*m_glowPower = saturate(m_glowPower - 4.0 * Time.deltaTime);
	m_glowAlpha = saturate(m_glowAlpha - 1.0 * Time.deltaTime);*/
	
	instance_activate_object(m_collider);
}
