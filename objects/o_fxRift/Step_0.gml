/// @description Update scale & effects

// update scale based on zdistance to player
var scale = 1.5;

var pl = getPlayer();
if (iexists(pl))
{
	scale *= lerp(0.25, 1.0, saturate(
			(1.0 - abs((pl.y - pl.z_height) - (y - z_height)) / 64.0)
			* saturate(pl.z_height / 72.0)
			)
		);
}

image_xscale = scale;
image_yscale = scale;

// update emissive
emissive.x = x;
emissive.y = y;
emissive.z = z;
emissive.z_height = z_height;
emissive.depth = depth;

// Do spalshes in the oasis
splash_ptime += Time.deltaTime * 7.0;

while (splash_ptime > 1.0)
{
	splash_ptime -= 1.0;
	
	var fader = instance_create_depth(x, y - 8, depth, o_shoreCircleBallFader);
		fader.x += random_range(-6, +6);
		fader.y += random_range(-1, +1);
		fader.image_xscale = 1 / 64.0;
		fader.image_yscale = fader.image_xscale * 0.75;
}