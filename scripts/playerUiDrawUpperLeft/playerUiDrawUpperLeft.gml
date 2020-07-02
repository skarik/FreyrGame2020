var pl = m_player;
var dx, dy;

draw_set_alpha(0.2);
draw_set_color(c_gray);
draw_text(0,50,string(o_PlayerTest.stats.m_health) + "/" + string(o_PlayerTest.stats.m_healthMax));

// Draw current usable active
if (instance_exists(o_PlayerTest.currentUsable) && !ctsGabbersHaveFocus() && o_PlayerTest.moEnabled)
{
	var usable = o_PlayerTest.currentUsable;
	dx = usable.x - (GameCamera.x - GameCamera.width / 2);
	dy = usable.y - (GameCamera.y - GameCamera.height / 2);
	
	var offset_direction = point_direction(o_PlayerTest.x, o_PlayerTest.y, usable.x, usable.y);
	//offset_direction = o_PlayerTest.facingDirection
	
	var useXoffset = lengthdir_x(20, offset_direction);
	var useYoffset = lengthdir_y(20, offset_direction);
	if (useXoffset == 0)
		useXoffset = 5;
		
	//var xSign = (o_PlayerTest.facingIndex == 3) ? -1 : +1;
	//var xSign = (useXoffset < 0.0) ? -1 : +1;
	var xSign = clamp(useXoffset * 0.4, -1.0, +1.0);
	
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	draw_line(dx, dy, dx + useXoffset, dy + useYoffset);
	draw_line(dx + useXoffset, dy + useYoffset, dx + useXoffset + 20 * xSign, dy + useYoffset);
	
	var string_xsize = 0.0;
	draw_set_alpha(1.0);
	//draw_set_halign((xSign < 0.0) ? fa_right : fa_left);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_color(c_white);
	draw_set_font(global.font_arvo9Bold);
	string_xsize = string_width_spaced(usable.m_actionName, 2);
	draw_text_spaced(dx + useXoffset + 3 * xSign + string_xsize * xSign * 0.5, dy - 1 + useYoffset, usable.m_actionName, 2);
	draw_set_valign(fa_top);
	draw_set_color(c_gray);
	draw_set_font(global.font_arvo9);
	string_xsize = string_width_spaced(usable.m_name, 2);
	draw_text_spaced(dx + useXoffset + 3 * xSign + string_xsize * xSign * 0.5, dy + 2 + useYoffset, usable.m_name, 2);
}

//
// Button contexts:

draw_set_font(f_04b03);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_color(c_white);
draw_set_alpha(1.0);

var dx_btn_base = 20 - smoothstep(m_inCutsceneBlend) * 200 - smoothstep(m_bag_totalBlend) * 200;
var dy_btn_base = 260 - 18 + 50;

dx = dx_btn_base;
dy = dy_btn_base;
//dy = 80 - smoothstep(m_inCutsceneBlend) * 200;
//draw_sprite(sui_buttonContext, 0, dx, dy);
//draw_text(dx + 20, dy + 15, "F");
{
	var inventory = m_player.inventory;
	var belt = null;
	if (inventory.belt_selection >= 0 && inventory.belt_selection < array_length_1d(inventory.belt))
		belt = inventory.belt[inventory.belt_selection];
	// draw the item sprite
	if (belt != null && belt.object != null)
	{
		drawControl(dx, dy, null, kControlDrawStyle_Skeuo, Settings.ctUseItem, m_player.lastControlType, m_player.lastGamepadType);
		
		var l_useText = "";
		// TODO: Move these into the item structure
		if (belt.onUse == generalYeetableOnUse)
			l_useText = "Yeet";
		else if (belt.onUse == generalConsumableOnUse)
			l_useText = "Eat";
		else if (belt.onUse == grappleOnUse)
			l_useText = "Grapple";
		else if (belt.onUse == generalSeedOnUse)
			l_useText = "Plant";
		
		dx += 18;
		shader_set(sh_colormask);
		draw_set_color(c_white);
		draw_sprite(object_get_sprite(belt.object), 0, dx + 1, dy);
		draw_sprite(object_get_sprite(belt.object), 0, dx - 1, dy);
		draw_sprite(object_get_sprite(belt.object), 0, dx, dy + 1);
		draw_sprite(object_get_sprite(belt.object), 0, dx, dy - 1);
		shader_reset();
		draw_set_color(c_white);
		draw_sprite(object_get_sprite(belt.object), 0, dx, dy);
		
		dx += 10;
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_font(global.font_arvo9);
		draw_set_color(c_white);
		draw_text_spaced(dx, dy, l_useText, 2);
	}
}


//dx = 20;
//dy = 100 - smoothstep(m_inCutsceneBlend) * 200;
dx = dx_btn_base;
dy = dy_btn_base + 21;
if (!o_PlayerTest.isBlocking)
{
	//draw_sprite(sui_buttonContext, (pl.m_currentInteractionType == kInteractionAttack) ? 1 : 0, dx, dy);
	if (pl.m_currentInteractionType == kInteractionAttack)
	{
		drawControl(dx, dy, null, kControlDrawStyle_Skeuo, Settings.ctAttack, m_player.lastControlType, m_player.lastGamepadType);
	}
	else
	{
		drawControl(dx, dy, null, kControlDrawStyle_Skeuo, Settings.ctUse, m_player.lastControlType, m_player.lastGamepadType);
	}
	
	dx += 18;
	if (pl.m_currentInteractionType == kInteractionTill)
	{
		draw_sprite(s_itemToolPickaxe, 0, dx, dy);
	}
	else if (pl.m_currentInteractionType == kInteractionTill2)
	{
		draw_sprite(s_itemToolHoe, 0, dx, dy);
	}
	else if (pl.m_currentInteractionType == kInteractionUse)
	{
		draw_sprite(s_itemResGear, 0, dx, dy);
	}
	else if (pl.m_currentInteractionType == kInteractionAttack)
	{
		draw_sprite(s_itemToolShield, 0, dx, dy);
	}
	
	dx += 10;
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_font(global.font_arvo9);
	draw_set_color(c_white);
	if (pl.m_currentInteractionType == kInteractionTill)
		draw_text_spaced(dx, dy, m_farmoverlay_targetString, 2);
	else if (pl.m_currentInteractionType == kInteractionTill2)
		draw_text_spaced(dx, dy, m_farmoverlay_targetString, 2);
	else if (pl.m_currentInteractionType == kInteractionUse)
		draw_text_spaced(dx, dy, "Interact", 2);
	else if (pl.m_currentInteractionType == kInteractionAttack)
		draw_text_spaced(dx, dy, "Kick", 2);
}
else
{
	//draw_sprite(sui_buttonContext, 0, dx, dy);
	drawControl(dx, dy, null, kControlDrawStyle_Skeuo, Settings.ctUse, m_player.lastControlType, m_player.lastGamepadType);
	
	var inventory = o_PlayerTest.inventory;
	var belt = null;
	if (inventory.belt_selection >= 0 && inventory.belt_selection < array_length_1d(inventory.belt))
		belt = inventory.belt[inventory.belt_selection];
	// draw the item sprite
	if (belt != null && belt.object != null)
	{
		shader_set(sh_colormask);
		draw_set_color(c_white);
		draw_sprite(object_get_sprite(belt.object), 0, dx + 1, dy);
		draw_sprite(object_get_sprite(belt.object), 0, dx - 1, dy);
		draw_sprite(object_get_sprite(belt.object), 0, dx, dy + 1);
		draw_sprite(object_get_sprite(belt.object), 0, dx, dy - 1);
		shader_reset();
		draw_set_color(c_white);
		draw_sprite(object_get_sprite(belt.object), 0, dx, dy);
	}
}
//draw_text(dx + 20, dy + 15, "LMB");

//dx = 15;
//dy = 115 - smoothstep(m_inCutsceneBlend) * 200
dx = dx_btn_base;
dy = dy_btn_base + 21 + 21;
//draw_sprite(sui_buttonContext, 0, dx, dy);
//draw_sprite(sui_useIcons, o_PlayerTest.isBlocking ? 0 : 1, dx + 8, dy + 7);
//draw_text(dx + 20, dy + 15, "RMB");
{
	drawControl(dx, dy, null, kControlDrawStyle_Skeuo, Settings.ctDodge, m_player.lastControlType, m_player.lastGamepadType);
	
	dx += 18;
	draw_sprite(sui_useIcons, o_PlayerTest.isBlocking ? 0 : 1, dx, dy);
	
	dx += 10;
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_font(global.font_arvo9);
	draw_set_color(c_white);
	draw_text_spaced(dx, dy, o_PlayerTest.isBlocking ? "Defend" : "Dodge", 2);
}

// DRAW HEALTH BAR
playerUiDrawUpperLeftHealthbar();
