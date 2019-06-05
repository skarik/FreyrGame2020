var dx, dy;

draw_set_alpha(0.2);
draw_set_color(c_gray);
draw_text(0,50,string(o_PlayerTest.stats.m_health) + "/" + string(o_PlayerTest.stats.m_healthMax));

var dx, dy;

// last usable
if (instance_exists(o_PlayerTest.currentUsable) && !exists(ob_CtsTalker) && o_PlayerTest.moEnabled)
{
	var usable = o_PlayerTest.currentUsable;
	dx = usable.x - (GameCamera.x - GameCamera.width / 2);
	dy = usable.y - (GameCamera.y - GameCamera.height / 2);
	
	var useXoffset = lengthdir_x(20, o_PlayerTest.facingDirection);
	var useYoffset = lengthdir_y(20, o_PlayerTest.facingDirection);
	if (useXoffset == 0)
		useXoffset = 5;
		
	var xSign = (o_PlayerTest.facingIndex == 3) ? -1 : +1;
	
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	draw_line(dx, dy, dx + useXoffset, dy + useYoffset);
	draw_line(dx + useXoffset, dy + useYoffset, dx + useXoffset + 20 * xSign, dy + useYoffset);
	
	draw_set_font(f_josefinSlab9);
	draw_set_alpha(1.0);
	draw_set_halign((o_PlayerTest.facingIndex == 3) ? fa_right : fa_left);
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
dy = 80 - smoothstep(m_inCutsceneBlend) * 200;
draw_sprite(sui_buttonContext, 0, dx, dy);
draw_text(dx + 20, dy + 15, "F");
{
	var inventory = o_PlayerTest.inventory;
	var belt = inventory.belt[inventory.belt_selection];
	// draw the item sprite
	if (belt.object != null)
	{
		shader_set(sh_colormask);
		draw_set_color(c_white);
		draw_sprite(object_get_sprite(belt.object), 0, dx + 8 + 1, dy + 4);
		draw_sprite(object_get_sprite(belt.object), 0, dx + 8 - 1, dy + 4);
		draw_sprite(object_get_sprite(belt.object), 0, dx + 8, dy + 4 + 1);
		draw_sprite(object_get_sprite(belt.object), 0, dx + 8, dy + 4 - 1);
		shader_reset();
		draw_set_color(c_white);
		draw_sprite(object_get_sprite(belt.object), 0, dx + 8, dy + 4);
	}
}


dx = 20;
dy = 100 - smoothstep(m_inCutsceneBlend) * 200;
draw_sprite(sui_buttonContext, 1, dx, dy);
if (o_PlayerTest.isBlocking)
{
	var inventory = o_PlayerTest.inventory;
	var belt = inventory.belt[inventory.belt_selection];
	// draw the item sprite
	if (belt.object != null)
	{
		shader_set(sh_colormask);
		draw_set_color(c_white);
		draw_sprite(object_get_sprite(belt.object), 0, dx + 8 + 1, dy + 4);
		draw_sprite(object_get_sprite(belt.object), 0, dx + 8 - 1, dy + 4);
		draw_sprite(object_get_sprite(belt.object), 0, dx + 8, dy + 4 + 1);
		draw_sprite(object_get_sprite(belt.object), 0, dx + 8, dy + 4 - 1);
		shader_reset();
		draw_set_color(c_white);
		draw_sprite(object_get_sprite(belt.object), 0, dx + 8, dy + 4);
	}
}
draw_text(dx + 20, dy + 15, "LMB");

// health bar
/*dx = 5; dy = 5;
draw_set_alpha(1.0);
draw_set_color(c_gray);
draw_rectangle(dx - 1, dy - 1, dx + o_PlayerTest.stats.m_healthMax + 1, dy + 10 + 1, false);
draw_set_color(c_dkgray);
draw_rectangle(dx, dy, dx + o_PlayerTest.stats.m_healthMax, dy + 10, false);
draw_set_color(c_red);
draw_set_alpha(0.7);
draw_rectangle(dx, dy, dx + o_PlayerTest.stats.m_health, dy + 10, false);*/

// health bar v2
dx = 5;
dy = 10 - smoothstep(m_inCutsceneBlend) * 200;
draw_set_alpha(1.0);
draw_sprite(sui_roboArm, 1, dx, dy);
var health_percent = clamp(o_PlayerTest.stats.m_health / o_PlayerTest.stats.m_healthMax, 0.0, 1.0);
draw_sprite_part(sui_roboArm, 2,
	0, 0,
	5, 30 * health_percent,
	dx + 16, dy + 32 + 30 * (1.0 - health_percent));

// time of day (the astrolabe)
dx = 60//GameCamera.width - 47;
dy = 10 - smoothstep(saturate(m_inCutsceneBlend - m_astrolabeForceBlend)) * 200;
/*
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
*/


draw_set_alpha(1.0);
draw_set_color(c_white);

dx += 45;
dy += 2;
draw_set_font(f_04b03);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

draw_set_halign(fa_right);
draw_text(dx - 2, dy, string(floor((o_dayNightCycle.m_timeOfDay + 11) % 12 + 1)));
draw_set_halign(fa_center);
draw_text(dx, dy, ":");
draw_set_halign(fa_right);
draw_text(dx + 7, dy, string(floor(frac(o_dayNightCycle.m_timeOfDay) * 6)));
draw_text(dx + 12, dy, string(floor(frac(o_dayNightCycle.m_timeOfDay) * 60) % 10));
draw_set_halign(fa_left);
draw_text(dx + 14, dy, (o_dayNightCycle.m_timeOfDay < 12) ? "AM" : "PM");
dx -= 45;
dy -= 2;

dx += 15;
dy += 25;
draw_sprite_ext(sui_astrolabeTimeOfDay, 0,
				dx, dy,
				1.0, 1.0,
				o_dayNightCycle.m_timeOfDay / 24.0 * 360.0,
				c_white, 1.0);
draw_sprite_ext(sui_astrolabeSeason, 0,
				dx, dy,
				1.0, 1.0,
				o_dayNightCycle.m_day / 28.0 * 90.0,
				c_white, 1.0);
draw_sprite(sui_astrolabeTopper, 0, dx, dy);


var day_string = "Spring";
if (o_dayNightCycle.m_day < 28)
	day_string = "Spring";
else if (o_dayNightCycle.m_day < 56)
	day_string = "Summer";
else if (o_dayNightCycle.m_day < 56+28)
	day_string = "Fall";
else if (o_dayNightCycle.m_day < 56+56)
	day_string = "Winter";
day_string = day_string + " " + string(o_dayNightCycle.m_day);
//draw_set_font(f_04b03);
//draw_set_halign(fa_center);
//draw_set_valign(fa_top);
//draw_text(dx, dy + 7, day_string);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(f_openSans7);
var pen_angle = 190;
for (var i = 0; i <= string_length(day_string); ++i)
{
	var str = string_char_at(day_string, i + 1);
	//var angle = 200 + 18 * i;
	pen_angle += string_width(str) / string_width("m") * 35.0;
	/*draw_text(dx + lengthdir_x(14, angle),
			  dy + lengthdir_y(14, angle),
			  str);*/
	draw_text_ext_transformed(
			dx + lengthdir_x(8, pen_angle),
			dy + lengthdir_y(8, pen_angle),
			str,
			0, 100,
			1.0, 1.0,
			pen_angle - 270);
}