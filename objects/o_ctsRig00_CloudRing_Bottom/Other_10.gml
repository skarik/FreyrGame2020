/// @description On draw

if (m_mesh_valid)
{
	shader_set(sh_rigcloudsTwotone);
	uvs = sprite_get_uvs(sbg_cloudlayer0, 0);
	shader_set_uniform_f(uTexSheetCoords, uvs[0], uvs[1], uvs[2] - uvs[0], uvs[3] - uvs[1]);
	shader_set_uniform_f(uMultipliedColorLow, 85.0/255, 84.0/255, 97.0/255, 1.0)
	shader_set_uniform_f(uMultipliedColorHigh, 107.0/255, 123.0/255, 137.0/255, 1.0);
	vertex_submit(m_mesh, pr_trianglelist, sprite_get_texture(sbg_cloudlayer0, 0));
	shader_reset();
}