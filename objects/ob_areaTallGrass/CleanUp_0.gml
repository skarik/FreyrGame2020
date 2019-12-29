/// @description free buffers

if (m_vbuf != null)
{
	vertex_delete_buffer(m_vbuf);
	m_vbuf = null;
}