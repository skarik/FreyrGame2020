/// @description Draw card

var uvs; 

event_user(0);

// enable depth testing
gpu_set_ztestenable(true);

// render the card mesh
shader_set(sh_tarotCard);
uvs = sprite_get_uvs(m_tarotCardSprite, 0);
shader_set_uniform_f(uTexSheetCoords, uvs[0], uvs[1], uvs[2] - uvs[0], uvs[3] - uvs[1]);
vertex_submit(m_mesh_card, pr_trianglelist, sprite_get_texture(m_tarotCardSprite, 0));
shader_reset();

// render the art mesh over-undered the card
if (surface_exists(m_artbuffer))
{
	shader_set(sh_tarotCardArtMask);
	uvs = sprite_get_uvs(m_tarotArtMaskSprite, 0);
	shader_set_uniform_f(uTexSheetCoords_Mask, uvs[0], uvs[1], uvs[2] - uvs[0], uvs[3] - uvs[1]);
	texture_set_stage(samplerArtMesh_Mask, surface_get_texture(m_artbuffer));
	vertex_submit(m_mesh_card, pr_trianglelist, sprite_get_texture(m_tarotArtMaskSprite, 0));
	shader_reset();
}

// render the label mesh
shader_set(sh_tarotCard);
uvs = sprite_get_uvs(m_tarotArtSprite, 0);
shader_set_uniform_f(uTexSheetCoords, uvs[0], uvs[1], uvs[2] - uvs[0], uvs[3] - uvs[1]);
vertex_submit(m_mesh_label, pr_trianglelist, sprite_get_texture(m_tarotArtSprite, 0));
shader_reset();

// disable depth testing
gpu_set_ztestenable(false);

event_user(1);