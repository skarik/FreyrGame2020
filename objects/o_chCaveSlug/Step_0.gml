/// @description Hang around 

if (m_aiState_hangState == 0)
{
	image_alpha = 0.0;
	z_height = 128;
	isPassthru = true;
	
	fxtimer_hangdropS += Time.deltaTime * random_range(-5.0, +5.0) * 10.0;
	fxtimer_hangdropS = clamp(fxtimer_hangdropS, 0.1, 3.5);
	fxtimer_hangdrop += Time.deltaTime * fxtimer_hangdropS;
	if (fxtimer_hangdrop > 1.0)
	{
		var rand_dist = random(8);
		var rand_dir = random(360);
		var drop = instance_create_depth(x, y, depth, o_ptcEmissiveWaterDrop);
			drop.x += lengthdir_x(rand_dist, rand_dir);
			drop.y += lengthdir_y(rand_dist, rand_dir);
			drop.z_height = z_height;
			drop.image_blend = c_crystalblue;
			drop.emissive_blend = merge_color(c_crystalblue, c_black, 0.5);
		
		fxtimer_hangdrop -= 1.0;
	}
}
else if (m_aiState_hangState == 1)
{
}
else if (m_aiState_hangState == 2)
{
	characterGroundMotionStep();
}