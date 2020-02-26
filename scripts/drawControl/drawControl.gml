/// @function drawControl(x, y, size, style, control, controlType, padType)
/// @desc Draws the control in the current active control scheme.
/// @param x {Real} 
/// @param y {Real}
/// @param size {unused}
/// @param style {unused}
/// @param control {Array} Control to draw, given by Settings.
/// @param controlType {kControl} Is ``lastControlType`` in a controlled object.
/// @param padType (kGamepadType} Is ``lastGamepadType`` in a controlled object.

var dx			= argument0;
var dy			= argument1;
var size		= argument2;
var style		= argument3;
var control		= argument4;
var controlType	= argument5;
var padType		= argument6;

var l_controlValue = null;

var l_currentAlpha = draw_get_alpha();

// Go through control, find the first valid control to draw
var control_length = array_length_1d(control);
for (var i = 0; i < control_length; i += 2)
{
	var l_context = control[i];
	var l_input = control[i + 1];
	if (l_context == controlType)
	{
		l_controlValue = l_input;
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
			l_controlValue = l_input;
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
	// Draw keyboard key + text
	draw_set_font(f_04b03);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(dx, dy, controlGetName(controlType, padType, l_controlValue));
}
else if (controlType == kControlMouse)
{
}
else if (controlType == kControlGamepad)
{
	var generic = (padType == kGamepadTypeGeneric);
	var ds = (padType == kGamepadTypeDualshock);
	
	var l_suiSprite = generic ? null : (ds ? null : sui_control16_xbox);
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
		case gp_stickl:		l_suiIndex = 11; break;
		case gp_stickr:		l_suiIndex = 12; break;
	}
	
	if (l_suiIndex != null)
		draw_sprite_ext(l_suiSprite, l_suiIndex, dx, dy, 1.0, 1.0, 0.0, c_white, l_currentAlpha);
	else if (l_controlValue == gp_padu
			|| l_controlValue == gp_padd
			|| l_controlValue == gp_padl
			|| l_controlValue == gp_padr)
	{
		var l_suiAngle = 0.0;
		if (l_controlValue == gp_padd)
			l_suiAngle = 180.0;
		else if (l_controlValue == gp_padl)
			l_suiAngle = 90.0;
		else if (l_controlValue == gp_padr)
			l_suiAngle = 270.0;
			
		draw_sprite_ext(l_suiSprite, 10, dx, dy, 1.0, 1.0, l_suiAngle, c_white, l_currentAlpha);
	}
		
}