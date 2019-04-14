var buffer = argument0;

// belt
buffer_write(buffer, buffer_s32, belt_size);
for (var i = 0; i < belt_size; ++i)
{
	buffer_write(buffer, buffer_string, belt_name[i]);
	buffer_write(buffer, buffer_string, object_get_name(belt_object[i]));
	buffer_write(buffer, buffer_s32, belt_count[i]);
	buffer_write(buffer, buffer_s32, belt_checkUse[i]);
	buffer_write(buffer, buffer_s32, belt_onUse[i]);
	buffer_write(buffer, buffer_s32, belt_type[i]);
}
buffer_write(buffer, buffer_s32, belt_selection);

// bag 1
buffer_write(buffer, buffer_s32, 0);
// bag 2
buffer_write(buffer, buffer_s32, 0);