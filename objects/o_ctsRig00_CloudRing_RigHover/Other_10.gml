/// @description On draw

if (m_mesh_valid)
{
	shader_set(sh_rigcloudsTwotone);
	uvs = sprite_get_uvs(sbg_cloudlayer1, 0);
	shader_set_uniform_f(uTexSheetCoords, uvs[0], uvs[1], uvs[2] - uvs[0], uvs[3] - uvs[1]);
	shader_set_uniform_f(uMultipliedColorLow, 31.0/255, 36.0/255, 10.0/255, 1.0)
	shader_set_uniform_f(uMultipliedColorHigh, 38.0/255, 50.0/255, 60.0/255, 1.0);
	vertex_submit(m_mesh, pr_trianglelist, sprite_get_texture(sbg_cloudlayer1, 0));
	shader_reset();
}