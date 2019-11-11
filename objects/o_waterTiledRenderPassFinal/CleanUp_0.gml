/// @description Clean up

if (surface_exists(surface_tilemapComposite))
{
	surface_free(surface_tilemapComposite);
	surface_tilemapComposite = null;
}