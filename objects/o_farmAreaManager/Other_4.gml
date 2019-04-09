/// @description load if file exists

event_user(0);

if (file_exists(buffer_name))
{
	var load_buffer = buffer_load(buffer_name);
	farmLoadState(load_buffer);
}