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

draw_set_alpha(0.2);
draw_set_color(c_gray);
draw_text(0,50,string(o_PlayerTest.stats.m_health) + "/" + string(o_PlayerTest.stats.m_healthMax));

var dx, dy;

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

// button contexts
draw_set_font(f_04b03);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_color(c_white);
draw_set_alpha(1.0);

dx = 40;
dy = 80;
draw_sprite(sui_buttonContext, 0, dx, dy);
draw_text(dx + 20, dy + 15, "Z");
{
	var inventory = o_PlayerTest.inventory;
	// draw the item sprite
	if (inventory.belt_object[inventory.belt_selection] != null)
	{
		shader_set(sh_colormask);
		draw_set_color(c_white);
		draw_sprite(object_get_sprite(inventory.belt_object[inventory.belt_selection]), 0, dx + 8 + 1, dy + 4);
		draw_sprite(object_get_sprite(inventory.belt_object[inventory.belt_selection]), 0, dx + 8 - 1, dy + 4);
		draw_sprite(object_get_sprite(inventory.belt_object[inventory.belt_selection]), 0, dx + 8, dy + 4 + 1);
		draw_sprite(object_get_sprite(inventory.belt_object[inventory.belt_selection]), 0, dx + 8, dy + 4 - 1);
		shader_reset();
		draw_set_color(c_white);
		draw_sprite(object_get_sprite(inventory.belt_object[inventory.belt_selection]), 0, dx + 8, dy + 4);
	}
}


dx = 20;
dy = 100;
draw_sprite(sui_buttonContext, 1, dx, dy);
draw_text(dx + 20, dy + 15, "X");

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

// time of day
dx = 60;
dy = 10;

draw_set_font(f_josefinSlab9);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1.0);
//draw_text(dx, dy + 40, string_format(o_dayNightCycle.m_timeOfDay, 4, 2));
//draw_text(dx, dy + 15, string_format((o_dayNightCycle.m_timeOfDay + 11) % 12 + 1, 4, 2) + " " + ((o_dayNightCycle.m_timeOfDay < 12) ? "AM" : "PM"));
draw_set_halign(fa_right);
draw_text(dx - 2, dy, string(floor((o_dayNightCycle.m_timeOfDay + 11) % 12 + 1)));
draw_set_halign(fa_center);
draw_text(dx, dy, ":");
draw_set_halign(fa_right);
draw_text(dx + 9, dy, string(floor(frac(o_dayNightCycle.m_timeOfDay) * 6)));
draw_text(dx + 16, dy, string(floor(frac(o_dayNightCycle.m_timeOfDay) * 60) % 10));
draw_set_halign(fa_left);
draw_text(dx + 20, dy, (o_dayNightCycle.m_timeOfDay < 12) ? "AM" : "PM");

draw_text(dx - 5, dy + 12, "Day " + string(o_dayNightCycle.m_day));

surface_reset_target();

//
// Normal Surface

surface_set_target(m_surfaceLightweight);
draw_clear_alpha(c_white, 0.0);

// tillable
if (instance_exists(o_PlayerTest.currentTillable) && !exists(ob_CtsTalker))
{
	var tillable = o_PlayerTest.currentTillable;
	dx = tillable.x - (GameCamera.x - GameCamera.width / 2);
	dy = tillable.y - (GameCamera.y - GameCamera.height / 2);
	
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	draw_set_color(c_white);
	draw_set_alpha(0.7);
	draw_rectangle(dx, dy, dx + 15, dy + 15, true);
	draw_set_alpha(1.0);
	
	// set target to display text properly
	surface_reset_target();
	surface_set_target(m_surface);
	
	draw_set_font(f_josefinSlab9);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	if (!tillable.tilled)
	{
		draw_text(dx + 8, dy - 4, "Till");
	}
	
	// reset target to proper one
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
}
if (o_PlayerTest.m_till_filldirt && !exists(ob_CtsTalker))
{
	dx = o_PlayerTest.m_till_x - 8 - (GameCamera.x - GameCamera.width / 2);
	dy = o_PlayerTest.m_till_y - 8 - (GameCamera.y - GameCamera.height / 2);
	
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	draw_set_color(c_white);
	draw_set_alpha(0.7);
	draw_rectangle(dx, dy, dx + 15, dy + 15, true);
	draw_set_alpha(1.0);
	
	// set target to display text properly
	surface_reset_target();
	surface_set_target(m_surface);
	
	draw_set_font(f_josefinSlab9);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_text(dx + 8, dy - 4, "Plow");
	
	// reset target to proper one
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
}
// buildable
if (o_PlayerTest.currentBuildable && !exists(ob_CtsTalker))
{
	dx = o_PlayerTest.currentBuildableX - (GameCamera.x - GameCamera.width / 2);
	dy = o_PlayerTest.currentBuildableY - (GameCamera.y - GameCamera.height / 2);
	
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	draw_set_color(c_blue);
	draw_set_alpha(0.9);
	draw_rectangle(dx + 1, dy + 1, dx + 14, dy + 14, true);
	draw_set_alpha(1.0);
}
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

// inventory:
var inventory = o_PlayerTest.inventory;
{
	// update the selector
	if (m_inventory_selectorTarget != inventory.belt_selection)
	{
		//if (m_inventory_selectorBlend <= 0.00 || m_inventory_selectorBlend >= 1.00)
		//{
		m_inventory_selectorStart = m_inventory_selector;
		m_inventory_selectorBlend = 0.00;
		//}
		m_inventory_selectorTarget = inventory.belt_selection;
		m_inventory_selectorTimerCd = 1.0;
		
		m_inventory_selectorNameTimerCd = 3.0;
	}
	
	// Move the selector around
	m_inventory_selector = lerp(
		m_inventory_selectorStart, 
		m_inventory_selectorTarget,
		bouncestep(smoothstep(m_inventory_selectorBlend))
		);
	m_inventory_selectorBlend = saturate(m_inventory_selectorBlend + Time.deltaTime * 3.0);
	
	// Cool off the selector
	m_inventory_selectorTimerCd -= Time.deltaTime;
	// Perform that blend for the blender
	if (m_inventory_selectorTimerCd > 0.0)
		m_inventory_selectorBlendCruft = saturate(m_inventory_selectorBlendCruft + Time.deltaTime * 6.0);
	else
		m_inventory_selectorBlendCruft = saturate(m_inventory_selectorBlendCruft - Time.deltaTime * 2.0);
		
	// if name doesn't match, we need to swap names
	if (m_inventory_selectorName != inventory.belt_name[inventory.belt_selection])
	{
		m_inventory_selectorNameTimerCd = -1.0;
		if (m_inventory_selectorNameBlend <= 0.0)
		{
			m_inventory_selectorName = inventory.belt_name[inventory.belt_selection];
			m_inventory_selectorNameTimerCd = 3.0;
		}
	}
		
	// Cool off the selector
	m_inventory_selectorNameTimerCd -= Time.deltaTime;
	// Perform that blend for the blender
	if (m_inventory_selectorNameTimerCd > 0.0)
		m_inventory_selectorNameBlend = saturate(m_inventory_selectorNameBlend + Time.deltaTime * 5.0);
	else
		m_inventory_selectorNameBlend = saturate(m_inventory_selectorNameBlend - Time.deltaTime * 5.0);
}
{
	dx = 5;
	dy = GameCamera.height - 30;
	// inventory selector bg
	surface_reset_target();
	surface_set_target(m_surface);
	var selector = m_inventory_selector;
	draw_sprite_ext(sui_gearMedium, 0,
		dx + 24 * selector + 15 - 6,
		dy + 15 + 6 + 40 * smoothstep(1.0 - m_inventory_selectorBlendCruft),
		1.0, 1.0, current_time * 0.01 - m_inventory_selector * 130.0, c_white, 1.0);
	draw_sprite_ext(sui_gearSmall, 0,
		dx + 24 * selector + 15 + 10,
		dy + 15 - 10 + 40 * bouncestep(smoothstep(1.0 - m_inventory_selectorBlendCruft)),
		1.0, 1.0, - current_time * 0.02 + m_inventory_selector * 230.0, c_white, 1.0);
	// inventory selector
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
	draw_set_color(c_white);
	draw_set_font(f_04b03);
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	for (var i = 0; i < inventory.belt_size; ++i)
	{
		draw_sprite(sui_bagBox, 0, dx + 24 * i, dy );
	
		if (inventory.belt_object[i] != null)
		{
			draw_sprite(object_get_sprite(inventory.belt_object[i]), 0, dx + 24 * i + 15, dy + 15);
			draw_text(dx + 24 * i + 25, dy + 25, string(inventory.belt_count[i]));
		}
	}
	// inventory selector fg
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
	draw_sprite(sui_arcaneSelect, 0, dx + 24 * selector + 15, dy + 15);
	// inventory item name
	surface_reset_target();
	surface_set_target(m_surface);
	draw_set_font(f_josefinSlab9);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_text(
		dx + 8 - 100.0 * smoothstep(1.0 - m_inventory_selectorNameBlend), dy - 20,
		m_inventory_selectorName);
		
	// reset target to proper one
	surface_reset_target();
	surface_set_target(m_surfaceLightweight);
}


draw_set_alpha(1.0); // clear here for now
surface_reset_target();