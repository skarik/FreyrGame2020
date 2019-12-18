var powerObjectType = o_livelyPoweredInfoTest;

// Update power counter
m_powerUpdateCounter += kPowerUpdateRate * Time.deltaTime;

// Each game tick...
if (m_powerUpdateCounter > 1.0)
{
	m_powerUpdateCounter = min(1.0, m_powerUpdateCounter - 1.0);
	
	//
	// Run power updates:
	if (m_powerUpdateStep == kPowerUpdateStep_CheckPower)
	{
		with (powerObjectType)
		{
			// Do we have a source?
			if (exists(m_powerSource))
			{
				// If we do, then we route the output
				m_powerInput = m_powerSource.m_powerOutput;
			}
			// If there is no source, we don't touch the powered state.
		}
		
		m_powerUpdateStep = kPowerUpdateStep_ProvidePower;
	}
	else if (m_powerUpdateStep == kPowerUpdateStep_ProvidePower)
	{
		with (powerObjectType)
		{
			// Do logic that creates m_powerOutput
			m_powerOutput = script_execute(m_powerCallback);
		}
		
		m_powerUpdateStep = kPowerUpdateStep_CheckPower;
	}
}