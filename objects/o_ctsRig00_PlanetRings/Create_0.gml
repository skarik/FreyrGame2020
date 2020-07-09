/// @description create the objects to draw

event_inherited();

// Update positioning & rotations
xscale = 20.0;
yscale = xscale;
zscale = xscale;
xrotation = 50;
yrotation = 60;

var kRadius = 100;
var kHeight = 18;
var kTexRepeat = 1;

//
// Grab shader uniforms
uTexSheetCoords = shader_get_uniform(sh_rigring, "uTexSheetCoords");

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

var kDivs = 11;
var kAngleDiv = 360 / kDivs;
for (var i = 0; i < kDivs; ++i)
{
	var angle_0 = i * kAngleDiv;
	var angle_1 = (i + 1) * kAngleDiv;
	
	var x_0 = lengthdir_x(kRadius, angle_0);
	var x_1 = lengthdir_x(kRadius, angle_1);
	var y_0 = lengthdir_y(kRadius, angle_0);
	var y_1 = lengthdir_y(kRadius, angle_1);
	
	var t_0 = i / kDivs * kTexRepeat;
	var t_1 = (i + 1) / kDivs * kTexRepeat;

	// tri 0
	vertex_position_3d(m_mesh, x_0, y_0, 0);
	vertex_color(m_mesh, c_white, 1.0);
	vertex_texcoord(m_mesh, 1.0, t_0);
	vertex_normal(m_mesh, 0, 0, 1);
	
	vertex_position_3d(m_mesh, x_0, y_0, kHeight);
	vertex_color(m_mesh, c_white, 1.0);
	vertex_texcoord(m_mesh, 0.0, t_0);
	vertex_normal(m_mesh, 0, 0, 1);
	
	vertex_position_3d(m_mesh, x_1, y_1, 0);
	vertex_color(m_mesh, c_white, 1.0);
	vertex_texcoord(m_mesh, 1.0, t_1);
	vertex_normal(m_mesh, 0, 0, 1);
	
	// tri 1
	vertex_position_3d(m_mesh, x_1, y_1, 0);
	vertex_color(m_mesh, c_white, 1.0);
	vertex_texcoord(m_mesh, 1.0, t_1);
	vertex_normal(m_mesh, 0, 0, 1);
	
	vertex_position_3d(m_mesh, x_0, y_0, kHeight);
	vertex_color(m_mesh, c_white, 1.0);
	vertex_texcoord(m_mesh, 0.0, t_0);
	vertex_normal(m_mesh, 0, 0, 1);
	
	vertex_position_3d(m_mesh, x_1, y_1, kHeight);
	vertex_color(m_mesh, c_white, 1.0);
	vertex_texcoord(m_mesh, 0.0, t_1);
	vertex_normal(m_mesh, 0, 0, 1);
}

// Finish up all meshes
vertex_end(m_mesh);
vertex_freeze(m_mesh);