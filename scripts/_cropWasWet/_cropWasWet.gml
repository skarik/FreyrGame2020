function _cropWasWet(argument0) {
	var day = argument0;

	// have we previously calculated it was watered? 
	if (ds_map_exists(m_watered, day))
	{
		// if so, return that value.
		return (m_watered[? day] != false);
	}

	// check if any day was raining
	if (weatherIsRaining(day))
	{
		// save that it was watered on this day
		m_watered[? day] = true;
		// return that it was watered.
		return true;
	}

	return false;


}
