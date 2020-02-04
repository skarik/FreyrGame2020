/// @description Open/close

event_inherited();

depthUpdate();

m_openBlend = motion1d_to(m_openBlend, max(m_powerInput, m_powerOutput), 1.0 * Time.deltaTime);

if (m_openBlend > 0.95)
{
	instance_deactivate_object(m_collider);
}
else
{
	instance_activate_object(m_collider);
}
