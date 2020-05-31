/// @description Update the blending

var pl = getPlayer();
if (iexists(pl))
{
	// If the player is in range, we want to blend into this position.
	if (abs(pl.x - x) < m_focusHalfWidth && abs(pl.y - y) < m_focusHalfHeight)
	{
		//m_blend += Time.deltaTime;
		m_selectionPriority += Time.deltaTime * 60.0;
		
		// If there's another area with a blend, then set our blend to be full ASAP
		/*if (iexists(o_PlayerCamera))
		{
			if (iexists(o_PlayerCamera.m_currentFocus) && o_PlayerCamera.m_currentFocus != id)
			{
				//m_blend = 1.0;
				m_selectionPriority = 1.0;
				// Force other one's blend to be full as well to prevent any jaggies.
				//o_PlayerCamera.m_currentFocus = max(o_PlayerCamera.m_currentFocus, 0.999);
			}
		}*/
	}
	else
	{
		//m_blend -= Time.deltaTime;
		m_selectionPriority -= Time.deltaTime * 60.0;
	}
}
else
{
	//m_blend -= Time.deltaTime;
	m_selectionPriority -= Time.deltaTime;
}

// Clamp the blending
//m_blend = saturate(m_blend);
m_selectionPriority = saturate(m_selectionPriority);

// Now update the player camera with this information
/*if (iexists(o_PlayerCamera))
{
	if (o_PlayerCamera.m_currentFocus == id || !iexists(o_PlayerCamera.m_currentFocus) || o_PlayerCamera.m_currentFocus.m_blend < m_blend)
	{
		// Update the current focus
		o_PlayerCamera.m_currentFocus = id;
		
		// Update the blending
		o_PlayerCamera.m_currentFocus1lend = smoothstep(m_blend);
		o_PlayerCamera.m_currentFocusX = x;
		o_PlayerCamera.m_currentFocusY = y;
		o_PlayerCamera.m_currentFocusGlue = m_focusGlue;
	}
}*/
// Moved to camera to facilitate blending between zones