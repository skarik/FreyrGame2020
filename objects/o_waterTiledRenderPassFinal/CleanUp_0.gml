/// @description Clean up

/*if (surface_exists(surface_tilemapComposite))
{
	surface_free(surface_tilemapComposite);
	surface_tilemapComposite = null;
}*/

surface_free_if_exists(surface_tilemapComposite);
surface_free_if_exists(surface_tilemapCompositeBlur);