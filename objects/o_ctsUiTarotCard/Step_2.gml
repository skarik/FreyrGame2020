/// @description Update offscreen-art

if (!surface_exists(m_artbuffer))
{
	m_artbuffer = surface_create(GameCamera.width, GameCamera.height);
}

surface_set_target(m_artbuffer);
draw_clear_alpha(c_black, 1.0);

// set up matrices
event_user(0);

var uvs; 

// render the art mesh
shader_set(sh_tarotCard);
uvs = sprite_get_uvs(m_tarotArtSprite, 0);
shader_set_uniform_f(uTexSheetCoords, uvs[0], uvs[1], uvs[2] - uvs[0], uvs[3] - uvs[1]);
vertex_submit(m_mesh_art, pr_trianglelist, sprite_get_texture(m_tarotArtSprite, 0));
shader_reset();

// reset matrices
event_user(1);

surface_reset_target();