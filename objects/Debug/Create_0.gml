captureModeEnabled = false;
recordModeEnabled = false;
convention_mode = false; // turn on for convention demos

// Enable debug mode for now
on = true;
draw_visible = false;

// Debug lines:
debug_line[0] = "";
debug_line_count = 0;

// Debug mode restart all swatch:
reset = convention_mode || debug_mode;
// Farm id
farm_id = current_time;