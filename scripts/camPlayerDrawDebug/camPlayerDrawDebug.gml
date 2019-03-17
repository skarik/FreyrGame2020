var center_x = GameCamera.x;
var center_y = GameCamera.y;

draw_set_alpha(1.0);

// Draw the center leeyway border
draw_set_color(c_white);
draw_rectangle(center_x - m_cam_leeway_x, center_y - m_cam_leeway_y,
			   center_x + m_cam_leeway_x, center_y + m_cam_leeway_y,
			   true);
// Draw the follow position
draw_set_color(c_red);
draw_circle(m_cam_last_target_x, m_cam_last_target_y, 4, true);

// Draw the lookahead boxes around the follow position
draw_set_color(c_orange);
draw_rectangle(m_cam_last_target_x - m_cam_lookahead_max_x, m_cam_last_target_y - m_cam_lookahead_max_y,
			   m_cam_last_target_x + m_cam_lookahead_max_x, m_cam_last_target_y + m_cam_lookahead_max_y,
			   true);
// Draw the lookahead line
draw_set_color(c_yellow);
draw_line(m_cam_last_target_x, m_cam_last_target_y,
		  m_cam_last_target_x + m_cam_lookahead_x, m_cam_last_target_y + m_cam_lookahead_y);
// Draw the lookahead position
draw_set_color(merge_color(c_white, c_yellow, 0.5));
draw_circle(m_cam_last_target_x + m_cam_lookahead_x, m_cam_last_target_y + m_cam_lookahead_y, 4, true);
// Draw the final position
draw_set_color(c_white);
draw_line(m_cam_last_target_x + m_cam_lookahead_x, m_cam_last_target_y + m_cam_lookahead_y,
	      m_cam_last_final_x, m_cam_last_final_y);
draw_circle(m_cam_last_final_x, m_cam_last_final_y, 4, true);