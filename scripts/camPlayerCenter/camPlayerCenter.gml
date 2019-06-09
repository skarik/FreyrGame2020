/// @function camPlayerCenter()
/// @description Removes the lookahead of all cameras, no matter from where it is called.

with (o_PlayerCamera)
{
	m_cam_lookahead_x = 0;
	m_cam_lookahead_y = 0;

	m_cam_last_final_x = m_cam_last_target_x;
	m_cam_last_final_y = m_cam_last_target_y;
}