event_inherited();

// animation update
playerAnimLateUpdate();

// usable & combat update
playerInteractEndStep();

// update area
var next_area = areaFromRoom(room);
if (canMove
	&& next_area != kAreaNoArea && next_area != m_currentArea
	&& !exists(ob_CtsTalker)
	&& !exists(o_uiNewArea))
{
	m_currentAreaTimer += min(0.1, Time.deltaTime);
	if (m_currentAreaTimer > 1.0)
	{
		m_currentArea = next_area;
		
		var notifier = new(o_uiNewArea);
			notifier.m_area = m_currentArea;
			
		debugOut("New area: " + areaGetName(next_area));
	}
}
else
{
	m_currentAreaTimer = 0.0;
}