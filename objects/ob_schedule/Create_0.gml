/// @description Setup

// Flag used to jump characters if we're just starting the room.
bFirstFrameSetup = true;

#macro kScheduleGoalNone 0
#macro kScheduleGoalMoveTo 1
#macro kScheduleGoalLeaveTo 2
#macro kScheduleGoalStayAt 3
#macro kScheduleGoalGone 4

// Initial schedule
m_scheduleActive = false;
m_schedule = [];

// Fill in missing connections
if (m_characterObjectIndex == null)
{
	if (iexists(m_character))
	{
		m_characterObjectIndex = m_character.object_index;
	}
}

// On create, do the OnSchedule
event_user(kEvent_ChOnSchedule3);