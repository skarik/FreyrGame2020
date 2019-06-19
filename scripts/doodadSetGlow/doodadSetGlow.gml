var doodad = argument0;

if (doodad.sprite_index == s_propStickTorch
	|| doodad.sprite_index == s_propStickTorchSmall
	|| doodad.sprite_index == s_propCampfire
	|| doodad.sprite_index == s_propLantern0)
{
	// Create a light on the doodad.
	with (doodad)
	{
		if (sprite_index == s_propLantern0)
		{
			instance_create_depth(x + image_xscale * 29, y - 35, 0, o_lightFireMedium);
		}
		else
		{
			instance_create_depth(x, y - sprite_yoffset + sprite_height * 0.1, 0, o_lightFireMedium);
		}
	}
}