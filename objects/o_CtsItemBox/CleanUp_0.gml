controlCleanup();

if (surface_exists(surface_shine_bg))
{
	surface_free(surface_shine_bg);
}

delete(glower);