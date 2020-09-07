function farmBuildSaveState() {
	var buffer = buffer_create(1024, buffer_grow, 1);

	// Save number of field bits
	var field_count = instance_number(o_fieldSquare);
	buffer_write(buffer, buffer_s32, field_count);
	// Save their states
	for (var i = 0; i < field_count; ++i)
	{
		var field = instance_find(o_fieldSquare, i);
		with (field)
		{
			fieldSaveState(buffer);
		}
	}

	// Save the water jars
	var jar_count = instance_number(o_potWater);
	buffer_write(buffer, buffer_s32, jar_count);
	// Save their states
	for (var i = 0; i < jar_count; ++i)
	{
		var jar = instance_find(o_potWater, i);
		with (jar)
		{
			buffer_write(buffer, buffer_string, object_get_name(object_index));
			jarSaveState(buffer);
		}
	}

	// Save number of crops
	var crop_count = instance_number(ob_crop);
	buffer_write(buffer, buffer_s32, crop_count);
	// Save their states
	for (var i = 0; i < crop_count; ++i)
	{
		var crop = instance_find(ob_crop, i);
		with (crop)
		{
			buffer_write(buffer, buffer_string, object_get_name(object_index));
			cropSaveState(buffer);
		}
	}

	return buffer;


}
