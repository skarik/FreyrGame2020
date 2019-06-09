/// @description Update the blending

var pl = getPlayer();
if (exists(pl))
{
	// If the player is in range, we want to blend into this position.
	if (abs(pl.x - x) < m_focusHalfWidth && abs(pl.y - y) < m_focusHalfHeight)
	{
		m_blend += Time.deltaTime;
	}
	else
	{
		m_blend -= Time.deltaTime;
	}
}
else
{
	m_blend -= Time.deltaTime;
}

// Clamp the blending
m_blend = saturate(m_blend);

// MNow update the player camera with this information
if (exists(o_PlayerCamera))
{
	if (o_PlayerCamera.m_currentFocus == id || !exists(o_PlayerCamera.m_currentFocus) || o_PlayerCamera.m_currentFocus.m_blend < m_blend)
	{
		// Update the current focus
		o_PlayerCamera.m_currentFocus = id;
		
		// Update the blending
		o_PlayerCamera.m_currentFocusBlend = smoothstep(m_blend);
		o_PlayerCamera.m_currentFocusX = x;
		o_PlayerCamera.m_currentFocusY = y;
		o_PlayerCamera.m_currentFocusGlue = m_focusGlue;
	}
}