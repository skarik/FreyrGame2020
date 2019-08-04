/// @description fade it out

m_radius -= Time.deltaTime * 40.0;
if (m_radius <= 0.0)
	delete(this);