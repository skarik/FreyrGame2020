/// @description Do time things here.

//Day has passed, so fucking reset the flags
if (floor(timeofdayGetHour()) == 0 && m_hourFlags[23] == 1) {
	//I swear, we better not change the number of hours in the day just be "cool"
	debugOut("Clearing m_hourFlags.");
	show_debug_message("Clearing m_hourFlags.");
	for (var i = 0; i < 24; i++) {
		m_hourFlags[i] = 0;
	}
}

//Do timey things in the most terrible fashion possible.
if (m_hourFlags[timeofdayGetHour()] == 0)
{
	debugOut("Doing things for hour: " + string(floor(timeofdayGetHour())));
	show_debug_message("Doing things for hour: " + string(floor(timeofdayGetHour())));
	//Go do eventy things with other objects in the game.
	/*for (var i = 0; i < instance_number(ob_characterGroundInteractable); i += 1) {
		with(instance_find(ob_characterGroundInteractable, i)) {
			event_user(kEvent_ChOnSchedule3);
		}
	}*/
	with (ob_characterGroundInteractable)
	{
		event_user(kEvent_ChOnSchedule3);
	}
	with (ob_schedule)
	{
		event_user(kEvent_ChOnSchedule3);
	}
	
	m_hourFlags[timeofdayGetHour()] = 1;
}
