var doodad = argument0;

if (doodad.sprite_index == s_propStickTorch
	|| doodad.sprite_index == s_propStickTorchSmall
	|| doodad.sprite_index == s_propCampfire)
{
	// Create a light on the doodad.
	with (doodad)
	{
		instance_create_depth(x, y - sprite_yoffset + sprite_height * 0.1, 0, o_lightFireMedium);
	}
}