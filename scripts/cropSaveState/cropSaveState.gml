function cropSaveState(argument0) {
	var buffer = argument0;

	buffer_write(buffer, buffer_s32, 0); //Padding
	buffer_write(buffer, buffer_f32, x);
	buffer_write(buffer, buffer_f32, y);
	buffer_write(buffer, buffer_f64, m_startDay);
	buffer_write(buffer, buffer_f64, m_startHour);
	buffer_write(buffer, buffer_f64, m_growValue);
	buffer_write(buffer, buffer_f64, 0.0); // Padding

	// Store the watered map as well
	var map_size = ds_map_size(m_watered);
	buffer_write(buffer, buffer_s32, map_size);
	var key = ds_map_find_first(m_watered);
	for (var i = 0; i < map_size; ++i)
	{
		// Get the key's value
		var value = ds_map_find_value(m_watered, key);
	
		// Write the key-value pair for watered
		buffer_write(buffer, buffer_u32, key);
		buffer_write(buffer, buffer_bool, value);
	
		// Get next key
		key = ds_map_find_next(m_watered, key);
	}


}
