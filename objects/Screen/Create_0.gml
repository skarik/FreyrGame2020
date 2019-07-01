/// @description Constants & render init

if (singleton_this()) exit;

width = 1280;
height = 720;
pixelScale = 2;

offset_x = 0;
offset_y = 0;

// Hide the cursor
window_set_cursor(cr_none);

// Disable automatic app-surface drawing.
application_surface_enable(false);
application_surface_draw_enable(false);

// Set up surfaces
m_outputSurface = null;
m_gameSurface = null;

// Set up output camera
m_outputCamera = camera_create_view(0, 0, Screen.width, Screen.height);

new(o_replatte);
new(o_darkness);

// Variables for keeping track of auto-screenshots
screenshot_auto_enabled = false;
screenshot_timer = 0;
screenshot_count = 0;

// Variables for keeping track of record mode
record_shot_output_count = 0;
record_shot_count = 0;
record_shot[0] = 0;