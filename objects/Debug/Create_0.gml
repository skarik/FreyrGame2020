captureModeEnabled = false;
recordModeEnabled = false;
convention_mode = true; // turn on for convention demos

// Enable debug mode for now
on = true;
show_squad_info = false;

// Debug lines:
debug_line[0] = "";
debug_line_count = 0;

// Debug mode restart all swatch:
reset = convention_mode || debug_mode;
// Farm id
farm_id = current_time;


// Debug effects
var record_overlay = new(o_debugRecordOverlay);
	record_overlay.persistent = true;
	

// status
gifWidth = 560;//Screen.width;// / Screen.pixelScale;
gifHeight = 560;//Screen.height;// / Screen.pixelScale;

if (convention_mode)
{
	window_set_fullscreen(true);
}