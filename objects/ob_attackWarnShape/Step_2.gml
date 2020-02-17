/// @description Update mesh

var vertex_count = array_length_1d(m_vertices);
var index_count = array_length_1d(m_indices);

if (vertex_count == 0 || index_count == 0)
{
	// Mark as not ready to draw
	mesh_ready = false;
}
else
{
	vertex_begin(mesh, vertexFormat);
	for (var index = 0; index < index_count; ++index)
	{
		var vertex = m_vertices[m_indices[index]];
		vertex_position(mesh, vertex[0], vertex[1]);
		vertex_color(mesh, vertex[2], saturate(vertex[3] * image_alpha))
	}
	vertex_end(mesh);
	
	// Recalculate text position based on mesh average
	if (m_draw_text)
	{
		text_x = 0.0;
		text_y = 0.0;
		for (var vert = 0; vert < vertex_count; ++vert)
		{
			var vertex = m_vertices[vert];
			text_x += vertex[0];
			text_y += vertex[1];
		}
		text_x /= vertex_count;
		text_y /= vertex_count;
	}
	
	// Make mesh as now ready
	mesh_ready = true;
}