var buffer = argument0;

// belt
belt_size = buffer_read(buffer, buffer_s32);
for (var i = 0; i < belt_size; ++i)
{
	belt_name[i]     = buffer_read(buffer, buffer_string);
	belt_object[i]   = object_get_index(buffer_read(buffer, buffer_string));
	belt_count[i]    = buffer_read(buffer, buffer_s32);
	belt_checkUse[i] = buffer_read(buffer, buffer_s32);
	belt_onUse[i]    = buffer_read(buffer, buffer_s32);
	belt_type[i]     = buffer_read(buffer, buffer_s32);
}
belt_selection = buffer_read(buffer, buffer_s32);

// bag 1
bag1_size = buffer_read(buffer, buffer_s32);
// bag 2
bag2_size = buffer_read(buffer, buffer_s32);