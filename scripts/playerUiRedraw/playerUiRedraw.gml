if (!surface_exists(m_surface))
{
	m_surface = surface_create(GameCamera.width, GameCamera.height);
}
if (!surface_exists(m_surfaceLightweight))
{
	m_surfaceLightweight = surface_create(GameCamera.width, GameCamera.height);
}
if (!surface_exists(m_surfaceLightweightBack))
{
	m_surfaceLightweightBack = surface_create(GameCamera.width, GameCamera.height);
}

if (surface_get_width(m_surface) != GameCamera.width || surface_get_height(m_surface) != GameCamera.height)
{
	surface_resize(m_surface, GameCamera.width, GameCamera.height);
}
if (surface_get_width(m_surfaceLightweight) != GameCamera.width || surface_get_height(m_surfaceLightweight) != GameCamera.height)
{
	surface_resize(m_surfaceLightweight, GameCamera.width, GameCamera.height);
}
if (surface_get_width(m_surfaceLightweightBack) != GameCamera.width || surface_get_height(m_surfaceLightweightBack) != GameCamera.height)
{
	surface_resize(m_surfaceLightweightBack, GameCamera.width, GameCamera.height);
}

// reset gpu state
gpu_set_blendenable(true);
gpu_set_blendmode(bm_normal);
draw_set_alpha(1.0);

// clear front surface
surface_set_target(m_surfaceLightweight);
draw_clear_alpha(c_white, 0.0);
surface_reset_target();

//
// Outlined Surface

surface_set_target(m_surface);
draw_clear_alpha(c_white, 0.0);

playerUiDrawUpperLeft();

surface_reset_target();

//
// Normal Surface

surface_set_target(m_surfaceLightweightBack);
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
// chest, underneathe the inventory
playerUiDrawChest();

//
// bag, under the inventory bar
playerUiDrawBag();

//
// inventory
playerUiDrawInventory();

//
// aimer
playerUiDrawAimer();

// on top of it all, draw the fuckin book
playerUiDrawBook();

// and on top of all that, draw the inventory/menu cursor
{
	// on top of it all, draw the cursor
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);

	draw_set_alpha(m_bag_totalBlend);
	_playerUiDrawCursor();
	draw_set_alpha(1.0);
}

draw_set_alpha(1.0); // clear here for now
surface_reset_target();
