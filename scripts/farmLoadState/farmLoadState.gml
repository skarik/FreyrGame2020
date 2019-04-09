var buffer = argument0;

// Load up number of field bits
var field_count = buffer_read(buffer, buffer_s32);
//show_message(string(field_count));
// Load up all the field bits!
for (var i = 0; i < field_count; ++i)
{
	var field = new(o_fieldSquare);
	with (field)
	{
		fieldLoadState(buffer);
	}
}

// Load up number of crop bits
var crop_count = buffer_read(buffer, buffer_s32);
// Load up all the crop bits!
for (var i = 0; i < crop_count; ++i)
{
	var crop_type = buffer_read(buffer, buffer_s32);
	var crop = new(crop_type);
	with (crop)
	{
		cropLoadState(buffer);
	}
}

// Now we need to link all the crops to the dirt under them:
// actually no, crops now do that themselves