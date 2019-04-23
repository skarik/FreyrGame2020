var dx, dy;

surface_reset_target();
surface_set_target(m_surfaceLightweightBack);

if (o_PlayerTest.canMove && !o_PlayerTest.m_isDead && !exists(ob_CtsTalker))
{
	// aimer
	dx = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
	dy = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));

	draw_set_color(c_black);
	draw_rectangle(dx - 3, dy - 1, dx + 3, dy + 1, false);
	draw_rectangle(dx - 1, dy - 3, dx + 1, dy + 3, false);
	draw_set_color(c_gold);
	draw_line(dx - 3, dy, dx + 2, dy);
	draw_line(dx, dy - 3, dx, dy + 2);

	if (!o_PlayerTest.m_isStunned && !o_PlayerTest.isBusyInteracting)
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