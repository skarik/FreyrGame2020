/// @description Draw door

draw_self();

if (surface_exists(target_buffer))
{
	draw_surface(target_buffer, x + target_worldoffset[0], y + target_worldoffset[1]);
}