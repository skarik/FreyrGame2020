/// @description Do time things here.

//Day has passed, so fucking reset the flags
if (floor(timeofdayGetHour()) == 0 && m_hourFlags[23] == 1) {
	//I swear, we better not change the number of hours in the day just be "cool"
	show_debug_message("Clearing m_hourFlags.");
	for (var i = 0; i < 24; i++) {
		m_hourFlags[i] = 0;
	}
}

//In the most terrible fashion possible.

if (m_hourFlags[timeofdayGetHour()] == 0) {
	//Go do eventy things with other objects in the game.
	show_debug_message("Doing things for hour: " + string(timeofdayGetHour()));
	m_hourFlags[timeofdayGetHour()] = 1;
}
