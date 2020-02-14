/// @description Set up the mesh

event_inherited();

var t_tex = sprite_get_texture(s_wiresTBase, 0);
var t_tex_uvs = texture_get_uvs(t_tex);

vertex_begin(m_mesh, m_meshFormat);
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
	
	vertex_position(m_mesh,
					pointA[0] - wire_width_delta[0],
					pointA[1] - wire_width_delta[1]);
	vertex_color(m_mesh, c_white, 1.0);
	vertex_texcoord(m_mesh, t_tex_uvs[0], t_tex_uvs[1]);
					
	vertex_position(m_mesh,
					pointA[0] + wire_width_delta[0],
					pointA[1] + wire_width_delta[1]);
	vertex_color(m_mesh, c_white, 1.0);
	vertex_texcoord(m_mesh, t_tex_uvs[2], t_tex_uvs[1]);
}
vertex_end(m_mesh);

m_meshReady = true;