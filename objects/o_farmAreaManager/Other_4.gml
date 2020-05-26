/// @description load if file exists

event_user(0);

if (file_exists(buffer_name))
{
	farmClearObjects();
	var load_buffer = buffer_load(buffer_name);
	farmReconstructLoadState(load_buffer);
}