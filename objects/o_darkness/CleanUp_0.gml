/// @description free the DARKness

if (surface_exists(m_darkness))
	surface_free(m_darkness);
	
if (surface_exists(m_bloom))
	surface_free(m_bloom);

if (surface_exists(m_bloom2))
	surface_free(m_bloom2);
	
if (surface_exists(m_compositingBuffer))
	surface_free(m_compositingBuffer);