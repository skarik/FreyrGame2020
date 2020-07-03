/// @description create the objects to draw

event_inherited();

translucent = true;

// Update positioning & rotations
z -= 5;
zrotation = 80;
xscale = 1.0;
yscale = xscale;
zscale = xscale;

//
// Grab shader uniforms
uTexSheetCoords = shader_get_uniform(sh_reference3d, "uTexSheetCoords");

//
// Create the vertex format:
vertex_format_begin();
{
	vertex_format_add_position_3d();
	vertex_format_add_color();
	vertex_format_add_texcoord();
	vertex_format_add_normal();
}
m_vformat = vertex_format_end();

m_mesh_valid = true;
m_mesh = vertex_create_buffer();
vertex_begin(m_mesh, m_vformat);

// add quad (ccw)
{
	// tri 0
	vertex_position_3d(m_mesh, -40 + 1000, 0, 2000);
	vertex_color(m_mesh, c_white, 0.1);
	vertex_texcoord(m_mesh, 0.0, 0.0);
	vertex_normal(m_mesh, 0, 0, 1);
	
	vertex_position_3d(m_mesh, -40, 0, 0);
	vertex_color(m_mesh, c_white, 0.1);
	vertex_texcoord(m_mesh, 0.0, 1.0);
	vertex_normal(m_mesh, 0, 0, 1);
	
	vertex_position_3d(m_mesh, +40 + 1000, 0, 2000);
	vertex_color(m_mesh, c_white, 0.1);
	vertex_texcoord(m_mesh, 1.0, 0.0);
	vertex_normal(m_mesh, 0, 0, 1);
	
	// tri 1
	vertex_position_3d(m_mesh, +40 + 1000, 0, 2000);
	vertex_color(m_mesh, c_white, 0.1);
	vertex_texcoord(m_mesh, 1.0, 0.0);
	vertex_normal(m_mesh, 0, 0, 1);
	
	vertex_position_3d(m_mesh, -40, 0, 0);
	vertex_color(m_mesh, c_white, 0.1);
	vertex_texcoord(m_mesh, 0.0, 1.0);
	vertex_normal(m_mesh, 0, 0, 1);
	
	vertex_position_3d(m_mesh, +40, 0, 0);
	vertex_color(m_mesh, c_white, 0.1);
	vertex_texcoord(m_mesh, 1.0, 1.0);
	vertex_normal(m_mesh, 0, 0, 1);
}

// Finish up all meshes
vertex_end(m_mesh);
vertex_freeze(m_mesh);