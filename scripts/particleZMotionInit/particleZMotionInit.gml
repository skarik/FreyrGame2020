function particleZMotionInit()
{
	depthInit();
	depthSetShadowPredrawFunction(depthShadowPredrawCircle2p5);
	depthSetShadowDrawFunction(depthShadowDrawCircle10);
	depthSetWorldDrawFunction(depthWorldDraw_Particle1);

	xspeed = 0;
	yspeed = 0;
	zspeed = 0;

	zgravity = 256.0;
}

function particleZMotionCleanup()
{
	depthFree();
}

function depthWorldDraw_Particle1()
{
	var dx, dy;
	dx = round(x);
	dy = round(y);
	
	draw_sprite_ext(sprite_index, image_index,
					dx, round(dy - z_height),
					image_xscale, image_yscale,
					image_angle,
					image_blend,
					image_alpha);
}