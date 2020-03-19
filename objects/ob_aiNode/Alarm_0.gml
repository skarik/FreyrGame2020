/// @description Create links

//ainodesLink(id);
if (!m_loaded || !m_valid)
{
	ainodesLoad(id);

	with (ob_character)
	{
		m_aipath_newpath = true; // FORCE A REPATH NOW
	}
}