/// @description Display the note

if (iexists(m_user) && m_user.id == o_PlayerTest.id)
{
	/*with (m_demuxer)
	{
		var mux_count = array_length_1d(m_muxOutputs);
		if (mux_count != 0)
			m_powerMuxSelection = (m_powerMuxSelection + 1) % mux_count;
		
	}*/
	m_enabled = !m_enabled;
	m_relay.m_powerInput = m_enabled ? 1.0 : 0.0;
}