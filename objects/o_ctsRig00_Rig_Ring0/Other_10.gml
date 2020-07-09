/// @description On draw

if (m_mesh_valid)
{
	shader_set(sh_reference3d);
	uvs = sprite_get_uvs(s_bgRigBits, 0);
	shader_set_uniform_f(uTexSheetCoords, uvs[0], uvs[1], uvs[2] - uvs[0], uvs[3] - uvs[1]);
	vertex_submit(m_mesh, pr_trianglelist, sprite_get_texture(s_bgRigBits, 0));
	shader_reset();
}