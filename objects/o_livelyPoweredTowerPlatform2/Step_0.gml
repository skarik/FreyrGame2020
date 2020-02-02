/// @description Update height based on power

m_height = motion1d_to(m_height, m_powerInput, Time.deltaTime * 0.5);

var calc_z_height = m_height * (5 * 16);

m_elevation.x = x;
m_elevation.y = y + (5 * 16) - calc_z_height - (3 * 16);
platform3_set_z(m_elevation, calc_z_height);

if (calc_z_height < 1)
{
	instance_deactivate_object(m_collider);
}
else
{
	instance_activate_object(m_collider);
	m_collider.calc_z_height = calc_z_height - 1;
}