/*if (iexists(m_currentFocus))
{
	if (m_currentFocus.object_index != o_cameraFocus
		&& m_currentFocus.object_index != o_cameraFocusDungeon)
	{
		// Don't do normal following if we're following something like an NPC.
		return;
	}
}*/

// Find the strongest blend.
var targetFocus = null;
var targetWeight = -1.0;

with (o_cameraFocus)
{
	//if (m_blend > 0.0)
	if (m_selectionPriority > 0.0)
	{
		//var currentWeight = 10.0 * m_blend;// + sqr(1024.0 * 100.0) / (sqr(x - o_PlayerCamera.x) + sqr(y - o_PlayerCamera.y));
		var currentWeight = 10.0 * m_selectionPriority;// + sqr(1024.0 * 100.0) / (sqr(x - o_PlayerCamera.x) + sqr(y - o_PlayerCamera.y));
		if (targetFocus == null || currentWeight > targetWeight)
		{
			targetFocus = id;
			targetWeight = currentWeight;
		}
	}
}

// Now that we have the new blend, we update our focus
/*if (m_currentFocus != targetFocus)
{
	if (m_currentFocus == null || m_currentFocus1lend <= 0.0)
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
}*/

// If we have a new major target to blend to, we want to make sure it's one of our focuses:
if (targetFocus != null && m_currentFocus0 != targetFocus && m_currentFocus1 != targetFocus)
{
	if (m_currentFocusSelector == 0.0 || m_currentFocusSelector == 1.0)
	{
		if (m_currentFocusSelector > 0.5)
			m_currentFocus0 = targetFocus;
		else
			m_currentFocus1 = targetFocus;
	}
}

// Now, we want to select the stronger focus
if ( (iexists(m_currentFocus0) && iexists(m_currentFocus1) && m_currentFocus1.m_selectionPriority > m_currentFocus0.m_selectionPriority)
	|| (!iexists(m_currentFocus0) && iexists(m_currentFocus1)) )
{
	if (m_currentFocusStrength == 0.0)
		m_currentFocusSelector = 1.0; // Instantly select correct selector if not in any focus mode right now
	else
		m_currentFocusSelector += Time.deltaTime;
}
else if ( (iexists(m_currentFocus0) && iexists(m_currentFocus1) && m_currentFocus0.m_selectionPriority > m_currentFocus1.m_selectionPriority)
	|| (iexists(m_currentFocus0) && !iexists(m_currentFocus1)) )
{
	if (m_currentFocusStrength == 0.0)
		m_currentFocusSelector = 0.0; // Instantly select correct selector if not in any focus mode right now
	else
		m_currentFocusSelector -= Time.deltaTime;
}
m_currentFocusSelector = saturate(m_currentFocusSelector);

// Finally, we need to blend the focus in
if ( (iexists(m_currentFocus0) && m_currentFocus0.m_selectionPriority > 0.0)
	|| (iexists(m_currentFocus1) && m_currentFocus1.m_selectionPriority > 0.0) )
{	// If there's any focus that has activated priority at all, then we blend in.
	m_currentFocusStrength += Time.deltaTime;
}
else
{	// No focuses that are activated? Don't bother blending in.
	m_currentFocusStrength -= Time.deltaTime;
}
m_currentFocusStrength = saturate(m_currentFocusStrength);

/*
// Blend focus as needed
m_previousToCurrentFocusBlend = saturate(m_previousToCurrentFocusBlend + Time.deltaTime * 1.0);

if (m_currentFocus != null)
{
	var transferBlend = smoothstep(m_previousToCurrentFocusBlend);
	m_currentFocusX = lerp(m_previousFocusX, m_currentFocus.x, transferBlend);
	m_currentFocusY = lerp(m_previousFocusY, m_currentFocus.y, transferBlend);
	m_currentFocusGlue = lerp(m_previousFocusGlue, m_currentFocus.m_focusGlue, transferBlend);
	//m_currentFocus1lend = iexists(m_previousFocus) ? smoothstep(saturate(m_currentFocus.m_blend * 2.0)) : smoothstep(m_currentFocus.m_blend);
	//m_currentFocus1lend = smoothstep(saturate(m_currentFocus.m_blend * 2.0));
	m_currentFocus1lend = smoothstep(saturate(m_currentFocus.m_blend));
}
else
{	// Ensure focus blend is zero
	m_currentFocus1lend = saturate(m_currentFocus1lend - Time.deltaTime);
}*/