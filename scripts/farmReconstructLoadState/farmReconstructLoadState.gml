function farmReconstructLoadState(argument0) {
	var buffer = argument0;

	//idelete(ob_pickupInventory);

	// Load up number of field bits
	var field_count = buffer_read(buffer, buffer_s32);
	//show_message(string(field_count));
	// Load up all the field bits!
	for (var i = 0; i < field_count; ++i)
	{
		var field = inew(o_fieldSquare);
		with (field)
		{
			fieldLoadState(buffer);
		}
	}

	// Load up number of jar bits
	var jar_count = buffer_read(buffer, buffer_s32);
	// Load up all the crop bits!
	for (var i = 0; i < jar_count; ++i)
	{
		var jar_type = object_get_index(buffer_read(buffer, buffer_string));
		var jar = inew(jar_type);
		with (jar)
		{
			jarLoadState(buffer);
		}
	}

	// Load up number of crop bits
	var crop_count = buffer_read(buffer, buffer_s32);
	// Load up all the crop bits!
	for (var i = 0; i < crop_count; ++i)
	{
		var crop_type = object_get_index(buffer_read(buffer, buffer_string));
		var crop = inew(crop_type);
		with (crop)
		{
			cropLoadState(buffer);
		}
	}

	// Now we need to link all the crops to the dirt under them:
	// actually no, crops now do that themselves


}
