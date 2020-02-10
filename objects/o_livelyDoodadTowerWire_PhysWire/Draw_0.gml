/// @description Draw the cable

if (!m_meshReady)
	exit;

var t_tex = sprite_get_texture(s_wiresTBase, 0);

draw_set_color(c_white);
vertex_submit(m_mesh, pr_trianglestrip, t_tex);
/*
draw_primitive_begin_texture(pr_trianglestrip, t_tex);
var wire_delta = [0, 0];
for (var i = 0; i < m_segmentCount; ++i)
{
	var pointA = m_segments[i];
	
	// Get the direction to the next point
	if (i < m_segmentCount - 1)
	{
		var pointB = m_segments[i + 1];
		wire_delta = [pointB[0] - pointA[0], pointB[1] - pointA[1]];
	}
	// Normalize direction & get the perpendicular direction
	var wire_delta_length = sqrt(sqr(wire_delta[0]) + sqr(wire_delta[1]));
	var wire_delta_unit = [wire_delta[0] / wire_delta_length, 
						   wire_delta[1] / wire_delta_length];
	var wire_width_delta = [wire_delta_unit[1] * 1.4, -wire_delta_unit[0] * 1.4];
	
	draw_vertex_texture(pointA[0] - wire_width_delta[0],
						pointA[1] - wire_width_delta[1],
						0.0, 0.0);
	draw_vertex_texture(pointA[0] + wire_width_delta[0],
						pointA[1] + wire_width_delta[1],
						1.0, 0.0);
}
draw_primitive_end();*/