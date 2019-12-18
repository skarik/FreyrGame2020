var powerObjectType = ob_livelyPowered;

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
				if (object_get_base_parent(m_powerSource.object_index) != powerObjectType)
				{
					debugOut("Redirecting power source from " + string(m_powerSource) + " to " + string(m_powerSource.m_powerSource));
					m_powerSource = m_powerSource.m_powerSource;
				}
				else
				{
					// If we do, then we route the output
					m_powerInput = script_execute(m_powerSource.m_powerSupplyCallback, m_powerSource.id, id);
				}
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