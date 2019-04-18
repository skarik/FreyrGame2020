if (!surface_exists(m_surface))
{
	m_surface = surface_create(GameCamera.width, GameCamera.height);
}
if (!surface_exists(m_surfaceLightweight))
{
	m_surfaceLightweight = surface_create(GameCamera.width, GameCamera.height);
}

if (surface_get_width(m_surface) != GameCamera.width || surface_get_height(m_surface) != GameCamera.height)
{
	surface_resize(m_surface, GameCamera.width, GameCamera.height);
}
if (surface_get_width(m_surfaceLightweight) != GameCamera.width || surface_get_height(m_surfaceLightweight) != GameCamera.height)
{
	surface_resize(m_surfaceLightweight, GameCamera.width, GameCamera.height);
}

// reset gpu state
gpu_set_blendenable(true);
gpu_set_blendmode(bm_normal);
draw_set_alpha(1.0);

//
// Outlined Surface

surface_set_target(m_surface);
draw_clear_alpha(c_white, 0.0);

playerUiDrawUpperLeft();

surface_reset_target();

//
// Normal Surface

surface_set_target(m_surfaceLightweight);
draw_clear_alpha(c_white, 0.0);

// tillable
if (instance_exists(o_PlayerTest.currentTillable) && !exists(ob_CtsTalker) && !o_PlayerTest.isBlocking)
{
	var tillable = o_PlayerTest.currentTillable;
	dx = tillable.x - (GameCamera.x - GameCamera.width / 2);
	dy = tillable.y - (GameCamera.y - GameCamera.height / 2);
	
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(0.7);
	draw_set_color(c_white);
	draw_rectangle(dx, dy, dx + 15, dy + 15, true);
	draw_set_color(c_crystalblue);
	draw_rectangle(dx + 1, dy + 1, dx + 14, dy + 14, true);
	draw_set_alpha(1.0);
	
	// set target to display text properly
	surface_reset_target();
	surface_set_target(m_surface);
	
	draw_set_font(f_josefinSlab9);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_color(c_white);
	if (!tillable.tilled)
	{
		draw_text(dx + 8, dy - 4, "Till");
	}
	
	// reset target to proper one
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
}
if (o_PlayerTest.m_till_filldirt && !exists(ob_CtsTalker) && !o_PlayerTest.isBlocking)
{
	dx = o_PlayerTest.m_till_x - 8 - (GameCamera.x - GameCamera.width / 2);
	dy = o_PlayerTest.m_till_y - 8 - (GameCamera.y - GameCamera.height / 2);
	
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	draw_set_color(c_white);
	draw_rectangle(dx, dy, dx + 15, dy + 15, true);
	draw_set_color(c_crystalblue);
	draw_rectangle(dx + 1, dy + 1, dx + 14, dy + 14, true);
	draw_set_alpha(1.0);
	
	// set target to display text properly
	surface_reset_target();
	surface_set_target(m_surface);
	
	draw_set_font(f_josefinSlab9);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_color(c_white);
	draw_text(dx + 8, dy - 4, "Plow");
	
	// reset target to proper one
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
}
// buildable
/*if (o_PlayerTest.currentBuildable && !exists(ob_CtsTalker))
{
	dx = o_PlayerTest.currentBuildableX - (GameCamera.x - GameCamera.width / 2);
	dy = o_PlayerTest.currentBuildableY - (GameCamera.y - GameCamera.height / 2);
	
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	draw_set_color(c_blue);
	draw_set_alpha(0.9);
	draw_rectangle(dx + 1, dy + 1, dx + 14, dy + 14, true);
	draw_set_alpha(1.0);
}*/
// tillable timer
if (o_PlayerTest.m_isTilling)
{
	dx = o_PlayerTest.x - (GameCamera.x - GameCamera.width / 2);
	dy = o_PlayerTest.y - (GameCamera.y - GameCamera.height / 2);
	
	draw_set_color(c_black);
	draw_rectangle(dx - 6, dy - 25, dx + 6, dy - 21, false);
	draw_set_color(c_white);
	draw_rectangle(dx - 5, dy - 24, dx - 5 + 10 * clamp(o_PlayerTest.m_till_timer, 0.0, 1.0), dy - 22, false);
}
// plantable
if (o_PlayerTest.m_plantable)
{
	dx = o_PlayerTest.m_plant_x - 8 - (GameCamera.x - GameCamera.width / 2);
	dy = o_PlayerTest.m_plant_y - 8 - (GameCamera.y - GameCamera.height / 2);
	
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	//draw_set_color(c_blue);
	draw_set_color(c_gold);
	draw_set_alpha(0.9);
	draw_rectangle(dx + 1, dy + 1, dx + 14, dy + 14, true);
	draw_set_alpha(1.0);
}

//
// inventory
playerUiDrawInventory();

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
draw_set_alpha(1.0); // clear here for now
surface_reset_target();

// on top of it all, draw the fuckin book
playerUiDrawBook();