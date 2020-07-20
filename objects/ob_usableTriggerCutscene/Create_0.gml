event_inherited();

#region Options

m_name = "Usable Trigger";
m_actionName = "Use";
/*m_canPickUp = false;
m_isSuperHeavy = false;
m_canThrow = false;
m_airFriction = 100;
m_usable = true;*/

#endregion

// Update to the input params
m_name = m_usableName;
m_actionName = m_usableAction;

// Update based on trigger mode
if (m_triggerMode == kTriggerOncePerPlaythrough)
{
	if (iflagsGetValue(id) != 0)
	{
		idelete(this);
	}
}
