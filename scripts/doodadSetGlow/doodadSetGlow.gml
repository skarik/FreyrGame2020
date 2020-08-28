var doodad = argument0;

if (doodad.sprite_index == s_propStickTorch
	|| doodad.sprite_index == s_propStickTorchShit
	|| doodad.sprite_index == s_propStickTorchSmall
	|| doodad.sprite_index == s_propLantern0
	|| doodad.sprite_index == s_propWallTorch)
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
else if (doodad.sprite_index == s_propBellFlower)
{
	with (doodad)
	{
		light = instance_create_depth(x, y - 2, 0, o_lightAllglowSmall);
		if (image_index == 0)
			light.image_blend = merge_color(make_color_rgb(116, 186, 234), c_ltblue, 0.5);
		else if (image_index == 1)
			light.image_blend = make_color_rgb(239, 172, 40);
		else if (image_index == 2)
			light.image_blend = make_color_rgb(239, 58, 12);
		light.image_blend = merge_color(light.image_blend, c_black, 0.5);
		
		emissive = instance_create_depth(x, y, 0, o_lightEmissiveDepth);
		emissive.target = id;
		emissive.image_blend = c_white;
		emissive.sprite_index = s_propBellFlower_Emissive;
		emissive.image_index = image_index;
	}
}
else if (doodad.sprite_index == s_propContainer)
{
	with (doodad)
	{
		light = instance_create_depth(x, y - 6, 0, o_lightAllglowMedium);
		light.image_blend = c_dkgray;
	}
}