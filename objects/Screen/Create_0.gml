/// @description Constants & render init

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