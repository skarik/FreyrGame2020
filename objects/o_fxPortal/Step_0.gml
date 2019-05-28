/// @description Insert description here
// You can write your code in this editor

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