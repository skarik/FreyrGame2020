var doodad = argument0;

if (doodad.sprite_index == s_propStickTorch
	|| doodad.sprite_index == s_propStickTorchSmall
	|| doodad.sprite_index == s_propLantern0)
{
	// Create a light on the doodad.
	with (doodad)
	{
		if (sprite_index == s_propLantern0)
		{
			light = instance_create_depth(x + image_xscale * 29, y - 35, 0, o_lightFireMedium);
		}
		else
		{
			light = instance_create_depth(x, y - sprite_yoffset + sprite_height * 0.1, 0, o_lightFireMedium);
		}
	}
}
else if (doodad.sprite_index == s_propDesertCampfire)
{
	// TODO some actual fire graphics
	light = instance_create_depth(x, y - 5, 0, o_lightFireMedium);
}
else if (doodad.sprite_index == s_propRuinCandle0)
{
	with (doodad)
	{
		light = instance_create_depth(x, y - 5, 0, o_lightFireSuperTiny);
	}
}
else if (doodad.sprite_index == s_propCMush0)
{
	with (doodad)
	{
		light = instance_create_depth(x, y - 8, 0, o_lightCrystalSmallGentle);
		
		emissive = instance_create_depth(x, y, 0, o_lightEmissiveDepth);
		emissive.target = id;
		emissive.image_blend = c_gray;
	}
}
else if (doodad.sprite_index == s_assetCGlowies)
{
	with (doodad)
	{
		light = instance_create_depth(x, y - 2, 0, o_lightCrystalTinyGentle);
		
		emissive = instance_create_depth(x, y, 0, o_lightEmissiveDepth);
		emissive.target = id;
		emissive.image_blend = c_gray;
	}
}