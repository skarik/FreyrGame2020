/// @function surface_free_if_exists(surface)
/// @param surface {Surface}

var surface = argument0;
if (surface_exists(surface))
{
	surface_free(surface);
	return true;
}
return false;