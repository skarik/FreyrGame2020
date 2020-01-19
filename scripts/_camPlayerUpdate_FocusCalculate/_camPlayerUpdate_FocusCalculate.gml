var final_x = argument0;
var final_y = argument1;
var currentFocus = argument2;

var focus_x = currentFocus.x;
var focus_y = currentFocus.y;

if (currentFocus.object_index != o_cameraFocus
	&& currentFocus.object_index != o_cameraFocusDungeon)
{
	// If not a camera focus object, just do lock-on following
	final_x = focus_x;
	final_y = focus_y;
}
else
{
	// If a specific camera focus object, then do more complicated camera glue.
	final_x = lerp(final_x, focus_x, currentFocus.m_focusGlue);
	final_y = lerp(final_y, focus_y, currentFocus.m_focusGlue * currentFocus.m_focusGlueYRatio);
}

return [final_x, final_y];