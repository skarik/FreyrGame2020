/// @description animate & destroy

m_radius -= m_radiusShrinkSpeed * Time.deltaTime;
m_fade += m_colorFadeSpeed * Time.deltaTime;

if (m_radius <= 0.0 || m_fade >= 1.0)
{
	idelete(this);
}