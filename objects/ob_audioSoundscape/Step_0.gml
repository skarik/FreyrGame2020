/// @description Fade in and out

if ((persistent && room != m_home) || m_homeless)
{
	m_homeless = true; // Mark as a hobo soundscape that must perish
	
	m_strength -= Time.deltaTime * m_definition.fadetime;
	if (m_strength < 0.0)
	{
		event_user(9);
		delete(this); // Free all the data
		exit;
	}
}
else
{
	if (!m_fadeinRequested)
	{
		// If in the range of the soundscape
		var pl = getPlayer();
		if (sqr(x - pl.x) + sqr(y - pl.y) < sqr(m_radius))
		{
			// Make all other soundscapes fade out
			with (object_index)
			{
				m_fadeinRequested = false;
				m_fadeoutRequested = true;
			}
		
			// Make this soundscape fade in
			m_fadeinRequested = true;
			m_fadeoutRequested = false;
		}
	}
	
	if (m_fadeinRequested)
	{		
		// Prime audio state on start
		if (m_strength <= 0)
			event_user(8);
			
		m_strength += Time.deltaTime * (m_definition.fadetime > 0 ? m_definition.fadetime : 10.0);
		
		if (m_strength >= 1.0)
			m_fadeinRequested = false;
	}
	
	if (m_fadeoutRequested)
	{
		m_strength -= Time.deltaTime * (m_definition.fadetime > 0 ? m_definition.fadetime : 10.0);
		
		// Prime audio state on start
		if (m_strength <= 0)
			event_user(9);
	}
	
	m_strength = saturate(m_strength);
}

// Update audio if it's active
if (m_strength > 0)
{
	event_user(10);
	persistent = true;
}
else
{
	persistent = false;
}