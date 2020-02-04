/// @description Update text & do SFX

if (!m_lanternPlaced)
{
	if (getPlayerHasItem(kPitemLantern))
	{
		m_actionName = "Place Lantern";
	}
	else
	{
		m_actionName = "???";
	}
	
	// Untock the value if not locked open
	if (m_gearTockAmount < 1.0)
	{
		m_gearTockAmount -= Time.deltaTime / 2.0;
		
		// Pitch should be high when going back
		if (exists(m_gearTockSfx)) {
			m_gearTockSfx.pitch = 0.66 * 2.0;
			sound_update_params(m_gearTockSfx);
		}
		
		// Stop audio if no longer tocking
		if (m_gearTockAmount <= 0.0)
			delete(m_gearTockSfx);
	}
}
else
{
	m_actionName = "Grab Lantern";
	
	// Tock the value 
	m_gearTockAmount += Time.deltaTime / 3.0;
	// Pitch should be high when going up
	if (exists(m_gearTockSfx)) 
		m_gearTockSfx.pitch = 0.66;
	// Stop the audio if at an end
	if (m_gearTockAmount >= 1.0)
		delete(m_gearTockSfx);
}

// Limit the tocker
m_gearTockAmount = saturate(m_gearTockAmount);

// Apply power manually to the door:
if (exists(m_targetPoweredDoor))
	m_targetPoweredDoor.m_powerInput = m_gearTockAmount;