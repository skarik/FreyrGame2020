var dx, dy;

// go to bottom layer surface
surface_reset_target();
surface_set_target(m_surfaceLightweightBack);

if (o_PlayerTest.canMove && !o_PlayerTest.m_isKOed && !ctsGabbersHaveFocus())
{
	// aimer
	dx = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
	dy = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));

	draw_set_color(c_black);
	gpu_set_blendmode_ext_sepalpha(bm_zero, bm_inv_src_alpha, bm_src_alpha, bm_one);
	draw_sprite(sui_aimer, 0, dx-1, dy);
	draw_sprite(sui_aimer, 0, dx+1, dy);
	draw_sprite(sui_aimer, 0, dx, dy-1);
	draw_sprite(sui_aimer, 0, dx, dy+1);
	gpu_set_blendmode(bm_normal);
	draw_set_color(c_white);
	draw_sprite(sui_aimer, 0, dx, dy);
	

	if (false && !o_PlayerTest.m_isStunned && !o_PlayerTest.isBusyInteracting)
	{
		// aim line
		dx = round(o_PlayerTest.aimingStartX - (GameCamera.x - GameCamera.width / 2));
		dy = round(o_PlayerTest.aimingStartY - (GameCamera.y - GameCamera.height / 2));

		var aimerDistanceDiv = 16.0;
		var aimerDistance = min(3.0,
								point_distance(o_PlayerTest.aimingStartX, o_PlayerTest.aimingStartY,
											   o_PlayerTest.uPosition, o_PlayerTest.vPosition) / aimerDistanceDiv - 1.0
								);
		for (var i = 0; i < aimerDistance; ++i)
		{
			dx += lengthdir_x(aimerDistanceDiv, o_PlayerTest.aimingDirection);
			dy += lengthdir_y(aimerDistanceDiv, o_PlayerTest.aimingDirection);
	
			draw_set_color(c_gold);
			draw_circle(round(dx), round(dy), 2, true);
		}
	}
}