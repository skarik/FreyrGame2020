/// @description On Triggered, toggle state

if (!m_moving)
{
	m_wantsOpen = !m_wantsOpen;
	m_moving = true;
}