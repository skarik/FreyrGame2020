/// @description On draw

if (m_mesh_valid)
{
	shader_set(sh_rigcloudsTwotone);
	uvs = sprite_get_uvs(sbg_cloudlayer1, 0);
	shader_set_uniform_f(uTexSheetCoords, uvs[0], uvs[1], uvs[2] - uvs[0], uvs[3] - uvs[1]);
	shader_set_uniform_f(uMultipliedColorLow, 0.0/255, 0.0/255, 0.0/255, 1.0)
	shader_set_uniform_f(uMultipliedColorHigh, 12.0/255, 8.0/255, 22.0/255, 1.0);
	vertex_submit(m_mesh, pr_trianglelist, sprite_get_texture(sbg_cloudlayer1, 0));
	shader_reset();
}