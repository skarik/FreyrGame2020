/// @description On draw

if (m_mesh_valid && surface_exists(buffer_waterTexture))
{
	shader_set(sh_rigwaterDistanceFade);
	//uvs = sprite_get_uvs(s_waterOverlayCaustic, 0);
	uvs = [0, 0, 1, 1];
	shader_set_uniform_f(uTexSheetCoords, uvs[0], uvs[1], uvs[2] - uvs[0], uvs[3] - uvs[1]);
	//vertex_submit(m_mesh, pr_trianglelist, sprite_get_texture(s_waterOverlayCaustic, 0));
	vertex_submit(m_mesh, pr_trianglelist, surface_get_texture(buffer_waterTexture));
	shader_reset();
}