/// @description Start motion

image_alpha = 0.0;
image_index = floor(random(image_number));
image_xscale = choose(1, -1);
image_yscale = choose(1, -1);

xspeed = 0;
yspeed = 0;

if (!iexists(o_ashadowCloudMover_Renderer))
	inew(o_ashadowCloudMover_Renderer);