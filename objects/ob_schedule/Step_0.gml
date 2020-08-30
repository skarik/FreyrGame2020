/// @description Update scheduled goals

if (!m_scheduleActive || ctsIsActive())
{
	exit;
}

var scheduleCount = array_length_1d(m_schedule);

if (scheduleCount == 0)
{
	m_scheduleActive = false; // Done.
}
else
{
	if (scheduleCount == 1)
	{
		var scheduleEntry = m_schedule[0];
		if (scheduleEntry[1] == kScheduleGoalGone)
		{
			// Delete target
			idelete(m_character);
			event_user(10); // Leave
			
			m_scheduleActive = false;
		}
	}
	
	var currentTime = timeofdayGetHour();
	
	// Go thru the schedule and find the first schedule we're good with
	var selectedSchedule = -1;
	for (var i = scheduleCount - 1; i >= 0; --i)
	{
		var scheduleEntry = m_schedule[i];
		if (currentTime >= scheduleEntry[0])
		{
			// Select this one
			selectedSchedule = i;
			break;
		}
	}
	if (selectedSchedule == -1)
	{
		selectedSchedule = scheduleCount - 1;
	}
	
	// Act upon that entry
	var scheduleEntry = m_schedule[selectedSchedule];
	
	if (scheduleEntry[1] == kScheduleGoalMoveTo)
	{
		if (!iexists(m_character))
		{
			// Get position from the previous entry
			var bHasValidPosition = false;
			var sx = 0;
			var sy = 0;
			if (selectedSchedule > 0)
			{
				var prevScheduleEntry = m_schedule[selectedSchedule];
				if (prevScheduleEntry[1] == kScheduleGoalMoveTo)
				{
					var scheduleEntryInstance = prevScheduleEntry[3];
					if (iexists(scheduleEntryInstance))
					{
						sx = scheduleEntryInstance.x;
						sy = scheduleEntryInstance.y;
					}
					else
					{
						var scheduleEntryPosition = prevScheduleEntry[2];
						sx = scheduleEntryPosition[0];
						sy = scheduleEntryPosition[1];
					}
					bHasValidPosition = true;
				}
			}
			if (!bHasValidPosition)
			{
				var scheduleEntryInstance = scheduleEntry[5];
				if (iexists(scheduleEntryInstance))
				{
					sx = scheduleEntryInstance.x;
					sy = scheduleEntryInstance.y;
				}
				else
				{
					var scheduleEntryPosition = scheduleEntry[4];
					sx = scheduleEntryPosition[0];
					sy = scheduleEntryPosition[1];
				}
			}
			// Spawn the character
			m_character = instance_create_depth(sx, sy, 0, m_characterObjectIndex);
		}
		
		// Get the position to go to
		var scheduleEntryInstance = scheduleEntry[3];
		var tx, ty;
		if (iexists(scheduleEntryInstance))
		{
			tx = scheduleEntryInstance.x;
			ty = scheduleEntryInstance.y;
		}
		else
		{
			var scheduleEntryPosition = scheduleEntry[2];
			tx = scheduleEntryPosition[0];
			ty = scheduleEntryPosition[1];
		}
		
		// Actually do the commands
		if (bFirstFrameSetup)
		{
			aiscriptRequestTeleport(m_character, kAiStyle_Scripted,
									tx, ty);
			m_scheduleActive = false;
		}
		else
		{
			aiscriptRequestMove(m_character, kAiStyle_Scripted,
								tx, ty,
								1.0);
			// Disable schedule update when arrive at the target (or are close enough)
			if (point_distance(m_character.x, m_character.y, tx, ty) < 10.0)
			{
				m_scheduleActive = false;
			}
		}
	}
	else if (scheduleEntry[1] == kScheduleGoalLeaveTo)
	{
		if (bFirstFrameSetup)
		{
			// Delete target
			idelete(m_character);
			event_user(10); // Leave
			
			m_scheduleActive = false;
		}
		else
		{
			// Get the position to go to
			var scheduleEntryInstance = scheduleEntry[3];
			var tx, ty;
			if (iexists(scheduleEntryInstance))
			{
				tx = scheduleEntryInstance.x;
				ty = scheduleEntryInstance.y;
			}
			else
			{
				var scheduleEntryPosition = scheduleEntry[2];
				tx = scheduleEntryPosition[0];
				ty = scheduleEntryPosition[1];
			}
			
			// Move the NPC out of the screen
			aiscriptRequestMove(m_character, kAiStyle_Scripted,
								tx, ty,
								1.0);
			// Find the ending case
			if (!iexists(m_character) || m_character.x <= 0 || m_character.y <= 0 || m_character.x > room_width || m_character.y > room_height)
			{
				idelete(m_character);
				m_scheduleActive = false;
			}
		}
	}
	// Nothing
	else if (scheduleEntry[1] == kScheduleGoalStayAt)
	{
		if (bFirstFrameSetup)
		{
			m_scheduleActive = false;
		}
		else
		{
			m_scheduleActive = false;
		}
	}
	
	bFirstFrameSetup = false;
}