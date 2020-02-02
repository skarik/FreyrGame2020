/// @description Free surfaces

if (surface_exists(m_bufferProjection))
	surface_free(m_bufferProjection);
	
delete(m_emissive);