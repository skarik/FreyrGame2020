/// @description Free buffers needed

if (!visible) exit;

if (surface_exists(target_buffer))
{
	surface_free(target_buffer);
}