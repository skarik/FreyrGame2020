/// @description Update depth & step

if (step == 0)
	depthUpdate();

var step_prev = step;
step += min(1, Time.deltaTime * 45.0);

// Hit ground effect
if (step_prev < 1 && step >= 1)
{
	var splat = instance_create_depth(x, y, 50, o_ptcWaterDropHit);
		splat.image_alpha = 0.99;
		splat.image_angle = choose(0, 1, 2, 3) * 90;
		splat.image_blend = image_blend;
		splat.image_speed = 1.7;
		
	if (areaPointInWater(x, y, 0))
	{
		var fader = instance_create_depth(x, y, depth, o_shoreCircleBallFader);
			fader.image_xscale = 1 / 64.0;
			fader.image_yscale = fader.image_xscale * 0.75;
	}
	else
	{
		instance_create_depth(x, y, 20, o_ptcDarkdrop);
	}
}

// Done
if (step_prev < 3 && step >= 3)
	delete(this);