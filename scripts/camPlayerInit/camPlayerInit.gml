m_cam_lookahead_x = 0;
m_cam_lookahead_y = 0;

m_cam_lookahead_blend = 0.0; // from 0.0 to 1.0
m_cam_lookahead_blend_speed = 2.0;
m_cam_lookahead_blend_speed_x = 160.0;
m_cam_lookahead_blend_speed_y = 90.0;

m_cam_lookahead_stillness_blend = 0.0;
m_cam_lookahead_stillness_blend_delay = 3.0;
m_cam_lookahead_stillness_blend_speed_x = m_cam_lookahead_blend_speed_x * 0.5;
m_cam_lookahead_stillness_blend_speed_y = m_cam_lookahead_blend_speed_y * 0.5;

m_cam_lookahead_max_x = 80.0;
m_cam_lookahead_max_y = 45.0;

m_cam_leeway_x = 16.0 * 3;
m_cam_leeway_y = 9.0 * 3;

m_cam_last_target_x = 0;
m_cam_last_target_y = 0;
m_cam_last_final_x = 0;
m_cam_last_final_y = 0;

#region Focus State
// Focuses are specifc points the camera will gravitate to when the player is nearby.
// They're used for centered things upon a specific area, dramatically.

// Current focus object is only used for switching between focuses
m_currentFocus = null;

// The actual focus blend state:
m_currentFocusBlend = 0.0;
m_currentFocusX = 0.0;
m_currentFocusY = 0.0;
// Glue is how much the player is followed rather than the focus.
// The view doesn't focus at all on 0.0, but doesnt move with the player at all on 1.0.
m_currentFocusGlue = 1.0;

#endregion