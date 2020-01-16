if (exists(m_currentFocus))
{
	if (m_currentFocus.object_index != o_cameraFocus
		&& m_currentFocus.object_index != o_cameraFocusDungeon)
	{
		// Don't do normal following if we're following something like an NPC.
		return;
	}
}

// Find the strongest blend.
var targetFocus = null;
var targetWeight = -1.0;

with (o_cameraFocus)
{
	if (m_blend > 0.0)
	{
		var currentWeight = 10.0 * m_blend;// + sqr(1024.0 * 100.0) / (sqr(x - o_PlayerCamera.x) + sqr(y - o_PlayerCamera.y));
		if (targetFocus == null || currentWeight > targetWeight)
		{
			targetFocus = id;
			targetWeight = currentWeight;
		}
	}
}

// Now that we have the new blend, we update our focus
if (m_currentFocus != targetFocus)
{
	if (m_currentFocus == null || m_currentFocusBlend <= 0.0)
	{
		m_previousToCurrentFocusBlend = 1.0;
	}
	else
	{
		m_previousFocusX = m_currentFocusX;
		m_previousFocusY = m_currentFocusY;
		m_previousFocusGlue = m_currentFocusGlue;
		m_previousToCurrentFocusBlend = 0.0;
	}
	m_previousFocus = m_currentFocus;
	m_currentFocus = targetFocus;
}

// Blend focus as needed
m_previousToCurrentFocusBlend = saturate(m_previousToCurrentFocusBlend + Time.deltaTime * 1.0);

if (m_currentFocus != null)
{
	var transferBlend = smoothstep(m_previousToCurrentFocusBlend);
	m_currentFocusX = lerp(m_previousFocusX, m_currentFocus.x, transferBlend);
	m_currentFocusY = lerp(m_previousFocusY, m_currentFocus.y, transferBlend);
	m_currentFocusGlue = lerp(m_previousFocusGlue, m_currentFocus.m_focusGlue, transferBlend);
	//m_currentFocusBlend = exists(m_previousFocus) ? smoothstep(saturate(m_currentFocus.m_blend * 2.0)) : smoothstep(m_currentFocus.m_blend);
	//m_currentFocusBlend = smoothstep(saturate(m_currentFocus.m_blend * 2.0));
	m_currentFocusBlend = smoothstep(saturate(m_currentFocus.m_blend));
}
else
{	// Ensure focus blend is zero
	m_currentFocusBlend = saturate(m_currentFocusBlend - Time.deltaTime);
}