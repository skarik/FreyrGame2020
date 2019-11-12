var tx = argument0;
var ty = argument1;
var tdir = argument2;

var poof, footstep, fader, sound_hit;

// Skip for certain types of NPCs
if (object_index == o_chCaveSlug
	|| object_index == o_chSlimeRed
	|| object_index == o_chBugLunarMoth)
	return;
// TODO: use this for slug

//
// Select the proper material
var ground_material = 0;
if (!areaInWater(x, y, z))
{
	ground_material = vtileGetMaterialAtPosition(x, y);	
}
else
{
	ground_material = kTileMaterial_Water;
}

//
// Effect creation:

if (ground_material == kTileMaterial_Water)
{
	fader = instance_create_depth(x, y, depth, o_shoreCircleBallFader);
	fader.x += random_range(-6, +6);
	fader.y += random_range(-1, +1) - 2;
	fader.image_alpha = 0.8;
	fader.image_xscale = 1 / 64.0;
	fader.image_yscale = fader.image_xscale * 0.75;
	fader.xspeed = xspeed * 0.2;
	fader.yspeed = yspeed * 0.2;
}