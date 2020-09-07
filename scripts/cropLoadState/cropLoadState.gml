function cropLoadState(argument0) {
	var buffer = argument0;

	buffer_read(buffer, buffer_s32); //Padding
	x			= buffer_read(buffer, buffer_f32);
	y			= buffer_read(buffer, buffer_f32);
	m_startDay	= buffer_read(buffer, buffer_f64);
	m_startHour	= buffer_read(buffer, buffer_f64);
	m_growValue	= buffer_read(buffer, buffer_f64);
	buffer_read(buffer, buffer_f64); // Padding

	// Load the watered map as well
	var map_size = buffer_read(buffer, buffer_s32);
	for (var i = 0; i < map_size; ++i)
	{
		// Read the key-value pair for watered
		var key		= buffer_read(buffer, buffer_u32);
		var value	= buffer_read(buffer, buffer_bool);
	
		// Store it up
		m_watered[? key] = value;
	}


}
