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


//
// Outlined Surface

surface_set_target(m_surface);
draw_clear_alpha(c_white, 0.0);

draw_set_alpha(0.2);
draw_set_color(c_gray);
draw_text(0,50,string(o_PlayerTest.stats.m_health) + "/" + string(o_PlayerTest.stats.m_healthMax));

var dx, dy;

// health bar

dx = 5; dy = 5;
draw_set_alpha(1.0);
draw_set_color(c_gray);
draw_rectangle(dx - 1, dy - 1, dx + o_PlayerTest.stats.m_healthMax + 1, dy + 10 + 1, false);
draw_set_color(c_dkgray);
draw_rectangle(dx, dy, dx + o_PlayerTest.stats.m_healthMax, dy + 10, false);
draw_set_color(c_red);
draw_set_alpha(0.7);
draw_rectangle(dx, dy, dx + o_PlayerTest.stats.m_health, dy + 10, false);

// health bar v2
dx = 5;
dy = 10;
draw_set_alpha(1.0);
draw_sprite(sui_roboArm, 0, dx, dy);

// last usable
if (instance_exists(o_PlayerTest.currentUsable) && !exists(ob_CtsTalker))
{
	var usable = o_PlayerTest.currentUsable;
	dx = usable.x - (GameCamera.x - GameCamera.width / 2);
	dy = usable.y - (GameCamera.y - GameCamera.height / 2);
	
	var useXoffset = lengthdir_x(20, o_PlayerTest.facingDirection);
	var useYoffset = lengthdir_y(20, o_PlayerTest.facingDirection);
	if (useXoffset == 0)
		useXoffset = 5;
		
	var xSign = (o_PlayerTest.facingAngle == 3) ? -1 : +1;
	
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	draw_line(dx, dy, dx + useXoffset, dy + useYoffset);
	draw_line(dx + useXoffset, dy + useYoffset, dx + useXoffset + 20 * xSign, dy + useYoffset);
	
	draw_set_font(f_josefinSlab9);
	draw_set_alpha(1.0);
	draw_set_halign((o_PlayerTest.facingAngle == 3) ? fa_right : fa_left);
	draw_set_valign(fa_bottom);
	draw_set_color(c_white);
	draw_text(dx + useXoffset + 3 * xSign, dy - 1 + useYoffset, usable.m_actionName);
	draw_set_valign(fa_top);
	draw_set_color(c_gray);
	draw_text(dx + useXoffset + 3 * xSign, dy + 2 + useYoffset, usable.m_name);
}


surface_reset_target();

//
// Normal Surface

surface_set_target(m_surfaceLightweight);
draw_clear_alpha(c_white, 0.0);

// inventory
dx = 5;
dy = GameCamera.height - 30;
for (var i = 0; i < 6; ++i)
{
	draw_sprite(sui_bagBox, 0, dx + 24 * i, dy );
}

surface_reset_target();

draw_set_alpha(1.0); // clear here for now