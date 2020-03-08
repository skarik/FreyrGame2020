var target_x = argument0;
var target_y = argument1;
var velocity_x = argument2;
var velocity_y = argument3;

//
// Update focuses:
_camPlayerUpdateFocus();

//
// Calculate offsets:

// Create lookahead lerper
if (abs(velocity_x) + abs(velocity_y) > 0.0)
{
	m_cam_lookahead_blend += Time.deltaTime * m_cam_lookahead_blend_speed;
}
else
{
	m_cam_lookahead_blend -= Time.deltaTime * m_cam_lookahead_blend_speed;
}
m_cam_lookahead_blend = clamp(m_cam_lookahead_blend, 0.0, 1.0);

// Move the lookahead
m_cam_lookahead_x += sign(velocity_x) * m_cam_lookahead_blend_speed_x * m_cam_lookahead_blend * Time.deltaTime;
m_cam_lookahead_y += sign(velocity_y) * m_cam_lookahead_blend_speed_y * m_cam_lookahead_blend * Time.deltaTime;
// Limit it
m_cam_lookahead_x = clamp(m_cam_lookahead_x, -m_cam_lookahead_max_x, +m_cam_lookahead_max_x);
m_cam_lookahead_y = clamp(m_cam_lookahead_y, -m_cam_lookahead_max_y, +m_cam_lookahead_max_y);
// Perform stillness blend
if (m_cam_lookahead_stillness_blend >= 1.00)
{
	var tspeed;
	tspeed = m_cam_lookahead_stillness_blend_speed_x * Time.deltaTime;
	if (abs(m_cam_lookahead_x) > tspeed)
		m_cam_lookahead_x -= sign(m_cam_lookahead_x) * tspeed;
	else
		m_cam_lookahead_x = 0.0;
		
	tspeed = m_cam_lookahead_stillness_blend_speed_y * Time.deltaTime;
	if (abs(m_cam_lookahead_y) > tspeed)
		m_cam_lookahead_y -= sign(m_cam_lookahead_y) * tspeed;
	else
		m_cam_lookahead_y = 0.0;
}


//
// Generate the final position:

var final_x = m_cam_last_final_x;
var final_y = m_cam_last_final_y;

// Add offset
var follow_x = target_x + m_cam_lookahead_x;
var follow_y = target_y + m_cam_lookahead_y;

// Drag the final_* along
final_x = clamp(final_x, follow_x - m_cam_leeway_x, follow_x + m_cam_leeway_x);
final_y = clamp(final_y, follow_y - m_cam_leeway_y, follow_y + m_cam_leeway_y);

// Clamp to the room size (needed here for look-ahead)
final_x = clamp(final_x, GameCamera.width / 2,  room_width  - GameCamera.width / 2);
final_y = clamp(final_y, GameCamera.height / 2, room_height - GameCamera.height / 2);

// Override with focus
if (exists(m_currentFocus0))
{
	var focus_coords = _camPlayerUpdate_FocusCalculate(final_x, final_y, m_currentFocus0);
	m_currentFocus0_X = focus_coords[0];
	m_currentFocus0_Y = focus_coords[1];
}
if (exists(m_currentFocus1))
{
	var focus_coords = _camPlayerUpdate_FocusCalculate(final_x, final_y, m_currentFocus1);
	m_currentFocus1_X = focus_coords[0];
	m_currentFocus1_Y = focus_coords[1];
}
var post_final_x = lerp(final_x, lerp(m_currentFocus0_X, m_currentFocus1_X, smoothstep(m_currentFocusSelector)), smoothstep(m_currentFocusStrength));
var post_final_y = lerp(final_y, lerp(m_currentFocus0_Y, m_currentFocus1_Y, smoothstep(m_currentFocusSelector)), smoothstep(m_currentFocusStrength));

// Override with the lock
var l_lockStrength = saturate(max(m_lockStrength, m_lockStrengthFader));
m_lockStrengthFader -= Time.deltaTime;
post_final_x = lerp(post_final_x, m_lockX, smoothstep(l_lockStrength));
post_final_y = lerp(post_final_y, m_lockY, smoothstep(l_lockStrength));

// Apply the center offset now
post_final_x += m_cam_focus_offset_x;
post_final_y += m_cam_focus_offset_y;

// Clamp to the room size
post_final_x = clamp(post_final_x, GameCamera.width / 2,  room_width  - GameCamera.width / 2);
post_final_y = clamp(post_final_y, GameCamera.height / 2, room_height - GameCamera.height / 2);

// Apply the rounded position
GameCamera.x = round(post_final_x);
GameCamera.y = round(post_final_y);
// Apply the game camera position
with (GameCamera)
{
	event_user(1);
}

//
// Update stillness based on final position:
if (abs(final_x - m_cam_last_final_x) + abs(final_y - m_cam_last_final_y) > 0.0)
{
	m_cam_lookahead_stillness_blend -= Time.deltaTime * 4.0;
}
else
{
	m_cam_lookahead_stillness_blend += Time.deltaTime / m_cam_lookahead_stillness_blend_delay;
}
m_cam_lookahead_stillness_blend = clamp(m_cam_lookahead_stillness_blend, 0.0, 1.0);


// Save frame info
m_cam_last_target_x = target_x;
m_cam_last_target_y = target_y;

m_cam_last_final_x = final_x;
m_cam_last_final_y = final_y;