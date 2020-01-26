/// @description draw circle of power range

draw_set_color(merge_color(c_crystalblue, c_electricity, m_livliness));
draw_set_alpha(saturate(0.5 + m_livliness * 0.5));
draw_circle(x, y, m_range, true);
draw_set_alpha(1.0);