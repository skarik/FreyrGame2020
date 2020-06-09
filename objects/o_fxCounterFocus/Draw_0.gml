/// @description Draw the focus

draw_set_color(c_black);

var shrink_lerp = 1.0 - power(saturate(1.0 - m_blend), 3.0);
var facing_dir = point_direction(m_source.x, m_source.y, m_target.x, m_target.y);

var target_vec_offset = [
	lengthdir_x(1, facing_dir + 90),
	lengthdir_y(1, facing_dir + 90)];
var source_vec_offset = [
	lengthdir_x(1, facing_dir + 90),
	lengthdir_y(1, facing_dir + 90)];
	
var target_offset = lerp(200, m_target.m_standingHeight + 8, shrink_lerp);
var source_offset = lerp(200, 25, shrink_lerp);

draw_primitive_begin(pr_trianglelist);

var delta;
delta = [
	(m_target.x + target_vec_offset[0] * target_offset) - (m_source.x + source_vec_offset[0] * source_offset),
	(m_target.y + target_vec_offset[1] * target_offset) - (m_source.y + source_vec_offset[1] * source_offset)];
draw_vertex(
	m_target.x + target_vec_offset[0] * target_offset + delta[0] * 20,
	m_target.y + target_vec_offset[1] * target_offset + delta[1] * 20);
draw_vertex(
	m_source.x + source_vec_offset[0] * source_offset - delta[0] * 20,
	m_source.y + source_vec_offset[1] * source_offset - delta[1] * 20);
draw_vertex(
	m_target.x + target_vec_offset[0] * target_offset * 10000,
	m_target.y + target_vec_offset[1] * target_offset * 10000);
	
delta = [
	(m_target.x - target_vec_offset[0] * target_offset) - (m_source.x - source_vec_offset[0] * source_offset),
	(m_target.y - target_vec_offset[1] * target_offset) - (m_source.y - source_vec_offset[1] * source_offset)];
draw_vertex(
	m_target.x - target_vec_offset[0] * target_offset + delta[0] * 20,
	m_target.y - target_vec_offset[1] * target_offset + delta[1] * 20);
draw_vertex(
	m_source.x - source_vec_offset[0] * source_offset - delta[0] * 20,
	m_source.y - source_vec_offset[1] * source_offset - delta[1] * 20);
draw_vertex(
	m_target.x - target_vec_offset[0] * target_offset * 10000,
	m_target.y - target_vec_offset[1] * target_offset * 10000);

draw_primitive_end();