/// @description perform states

// Update vfx
if (m_vfxWorldFlashRequested)
{
	m_vfxWorldFlash = min(1.0, m_vfxWorldFlash + Time.deltaTime * 7.0);
	if (m_vfxWorldFlash >= 1.0)
	{
		m_vfxWorldFlashRequested = false;
	}
}
else
{
	m_vfxWorldFlash = max(0.0, m_vfxWorldFlash - Time.deltaTime * 5.0);
}


// Update states:

// Fade in thanks
if (m_state == 0)
{
	if (m_fade == 0)
	{
		m_vfxWorldFlashRequested = true;
	}
	m_fade += Time.deltaTime;
	if (m_fade >= 1.0)
	{
		m_fade = 1.0;
		m_state = 1;
	}
}
// Fade in message
else if (m_state == 1)
{
	// Hold the message on the screen
	m_fadeTotalMessage += Time.deltaTime;
	if (m_fadeTotalMessage >= 1.0)
	{
		m_fadeTotalMessage = 1.0;
		m_state = 2;
	}
}
// Hold message
else if (m_state == 2)
{
	m_fadeOutTimer += Time.deltaTime;
	if (m_fadeOutTimer > 6.0)
	{
		m_state = 3;
	}
}
// Fade out
else if (m_state == 3)
{
	m_fadeTotalMessage -= Time.deltaTime;
	m_fade -= Time.deltaTime;
	
	if (m_fade <= 0.0)
	{
		idelete(this);
	}
}