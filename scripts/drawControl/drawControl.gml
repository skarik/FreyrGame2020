/// @function drawControl(x, y, size, style, control, controlType, padType)
/// @desc Draws the control in the current active control scheme.
/// @param x {Real} 
/// @param y {Real}
/// @param size {unused}
/// @param style {kControlDrawStyle}
/// @param control {Array} Control to draw, given by Settings.
/// @param controlType {kControl} Is ``lastControlType`` in a controlled object.
/// @param padType (kGamepadType} Is ``lastGamepadType`` in a controlled object.

#macro kControlDrawStyle_Flat 0
#macro kControlDrawStyle_Skeuo 1

var dx			= argument0;
var dy			= argument1;
var size		= argument2;
var style		= argument3;
var control		= argument4;
var controlType	= argument5;
var padType		= argument6;

var l_controlValue = null;
var l_currentAlpha = draw_get_alpha();
var l_currentColor = draw_get_color();

if (style == null)
	style = kControlDrawStyle_Flat;

// Go through control, find the first valid control to draw
var control_length = array_length_1d(control);
for (var i = 0; i < control_length; i += 2)
{
	var l_context = control[i];
	var l_input = control[i + 1];
	if (l_context == controlType)
	{
		l_controlValue = abs(l_input); // Abs because sign is only the direction of the input
		break;
	}
}
// If invalid, must be mouse & keyboard, so try to find any match for those
if (l_controlValue == null && (controlType == kControlKB || controlType == kControlMouse))
{
	for (var i = 0; i < control_length; i += 2)
	{
		var l_context = control[i];
		var l_input = control[i + 1];
		if (l_context == kControlKB || l_context == kControlMouse)
		{
			controlType = l_context; // Force updated control type.
			l_controlValue = abs(l_input); // Abs because sign is only the direction of the input
			break;
		}
	}
}

// Draw the control
if (l_controlValue == null)
{
	// Draw unbound note
	draw_set_font(f_04b03);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(dx, dy, "<unbound>");
}
else if (controlType == kControlKB)
{
	var l_suiSprite = (style == kControlDrawStyle_Flat) ? sui_control16f_kb : sui_control16s_kb;
	var l_suiIndex = null;
	
	switch (l_controlValue)
	{
		case vk_space:			l_suiIndex = 1; break;
	}

	// Draw spacebar
	if (l_suiIndex != null)
	{
		draw_sprite_ext(l_suiSprite, l_suiIndex, dx, dy, 1.0, 1.0, 0.0, c_white, l_currentAlpha);
	}
	// Draw keyboard key + text
	else
	{
		draw_sprite_ext(l_suiSprite, 0, dx, dy, 1.0, 1.0, 0.0, c_white, l_currentAlpha);
		
		draw_set_font(global.font_arvo9Bold);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_color(c_black);
		draw_text(dx, dy - 1, controlGetName(controlType, padType, l_controlValue));
	}
}
else if (controlType == kControlMouse)
{
	var l_suiSprite = (style == kControlDrawStyle_Flat) ? sui_control16f_mouse : sui_control16s_mouse;
	var l_suiIndex = null;
	switch (l_controlValue)
	{
		case mb_left:			l_suiIndex = 1; break;
		case mb_right:			l_suiIndex = 2; break;
		case mb_middle:			l_suiIndex = 3; break;
		case kMouseWheelUp:		l_suiIndex = 4; break;
		case kMouseWheelDown:	l_suiIndex = 5; break;
	}
	
	// Draw mouse button
	if (l_suiIndex != null)
		draw_sprite_ext(l_suiSprite, l_suiIndex, dx, dy, 1.0, 1.0, 0.0, c_white, l_currentAlpha);
}
else if (controlType == kControlGamepad)
{
	var generic = (padType == kGamepadTypeGeneric);
	var ds = (padType == kGamepadTypeDualshock);
	
	var l_suiSprite = (style == kControlDrawStyle_Flat) ? 
						(generic ? null : (ds ? null : sui_control16f_xbox)) :
						(generic ? null : (ds ? null : sui_control16s_xbox));
	var l_suiIndex = null;
	switch (l_controlValue)
	{
		case gp_face1:		l_suiIndex = 0; break;
		case gp_face2:		l_suiIndex = 1; break;
		case gp_face3:		l_suiIndex = 2; break;
		case gp_face4:		l_suiIndex = 3; break;
		case gp_shoulderl:	l_suiIndex = 4; break;
		case gp_shoulderr:	l_suiIndex = 5; break;
		case gp_shoulderlb:	l_suiIndex = 6; break;
		case gp_shoulderrb: l_suiIndex = 7; break;
		case gp_select:		l_suiIndex = 8; break;
		case gp_start:		l_suiIndex = 9; break;
		case gp_padu:		l_suiIndex = 10; break;
		case gp_padd:		l_suiIndex = 11; break;
		case gp_padl:		l_suiIndex = 12; break;
		case gp_padr:		l_suiIndex = 13; break;
		case gp_stickl:		l_suiIndex = 14; break;
		case gp_stickr:		l_suiIndex = 15; break;
	}
	
	// Draw the pad button
	if (l_suiIndex != null)
		draw_sprite_ext(l_suiSprite, l_suiIndex, dx, dy, 1.0, 1.0, 0.0, c_white, l_currentAlpha);
}

draw_set_color(l_currentColor);