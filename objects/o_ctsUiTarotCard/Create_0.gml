/// @description Create meshes & options

m_name = ""; // Generated in Tarot UI

m_tarotBaseSprite = sui_tarotTextureBase;
m_tarotBaseWidth = sprite_get_width(m_tarotBaseSprite);
m_tarotBaseHeight = sprite_get_height(m_tarotBaseSprite);
m_tarotBaseDepth = 10;
m_tarotArtDepth = 50;

m_tarotCardSprite = sui_tarotTextureStrip;
m_tarotArtMaskSprite = sui_tarotTextureMaskStrip;
m_tarotArtSprite = sui_tarotStaveAce;

//
// Set up initial position
z = 10;
xrot = 0;
yrot = 0;
zrot = 0;

//
// Set up initial render options
if (exists(o_ctsUiTarot))
	depth = o_ctsUiTarot.depth - 10; // Make tarot cards draw last, as they seem to mess up any rendering after.

//
// Grab shader uniforms
uTexSheetCoords = shader_get_uniform(sh_tarotCard, "uTexSheetCoords");
//uMatrixMVP = shader_get_uniform(sh_tarotCard, "uMatrixMVP");

uTexSheetCoords_Mask = shader_get_uniform(sh_tarotCardArtMask, "uTexSheetCoords");
samplerArtMesh_Mask = shader_get_sampler_index(sh_tarotCardArtMask, "samplerArtMesh");

//
// Set up offscreen buffer
m_artbuffer = surface_create(GameCamera.width, GameCamera.height);

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

//
// There are three meshes: CARD, ART, and LABEL
// Need to create all three.

m_mesh_card = vertex_create_buffer();
vertex_begin(m_mesh_card, m_vformat);

m_mesh_art = vertex_create_buffer();
vertex_begin(m_mesh_art, m_vformat);

m_mesh_label = vertex_create_buffer();
vertex_begin(m_mesh_label, m_vformat);

// front face (CARD):
vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
vertex_color(m_mesh_card, c_white, 1.0);
vertex_texcoord(m_mesh_card, 0.0, 0.0);
vertex_normal(m_mesh_card, 0, 0, -1);
vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
vertex_color(m_mesh_card, c_white, 1.0);
vertex_texcoord(m_mesh_card, 0.25, 0.0);
vertex_normal(m_mesh_card, 0, 0, -1);
vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
vertex_color(m_mesh_card, c_white, 1.0);
vertex_texcoord(m_mesh_card, 0.0, 1.0);
vertex_normal(m_mesh_card, 0, 0, -1);

vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
vertex_color(m_mesh_card, c_white, 1.0);
vertex_texcoord(m_mesh_card, 0.25, 0.0);
vertex_normal(m_mesh_card, 0, 0, -1);
vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
vertex_color(m_mesh_card, c_white, 1.0);
vertex_texcoord(m_mesh_card, 0.25, 1.0);
vertex_normal(m_mesh_card, 0, 0, -1);
vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
vertex_color(m_mesh_card, c_white, 1.0);
vertex_texcoord(m_mesh_card, 0.0, 1.0);
vertex_normal(m_mesh_card, 0, 0, -1);

// front face (ART):
{
	vertex_position_3d(m_mesh_art, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, m_tarotArtDepth);
	vertex_color(m_mesh_art, c_white, 1.0);
	vertex_texcoord(m_mesh_art, 0.0, 0.0);
	vertex_normal(m_mesh_art, 0, 0, -1);
	vertex_position_3d(m_mesh_art, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, m_tarotArtDepth);
	vertex_color(m_mesh_art, c_white, 1.0);
	vertex_texcoord(m_mesh_art, 0.5, 0.0);
	vertex_normal(m_mesh_art, 0, 0, -1);
	vertex_position_3d(m_mesh_art, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, m_tarotArtDepth);
	vertex_color(m_mesh_art, c_white, 1.0);
	vertex_texcoord(m_mesh_art, 0.0, 1.0);
	vertex_normal(m_mesh_art, 0, 0, -1);

	vertex_position_3d(m_mesh_art, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, m_tarotArtDepth);
	vertex_color(m_mesh_art, c_white, 1.0);
	vertex_texcoord(m_mesh_art, 0.5, 0.0);
	vertex_normal(m_mesh_art, 0, 0, -1);
	vertex_position_3d(m_mesh_art, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, m_tarotArtDepth);
	vertex_color(m_mesh_art, c_white, 1.0);
	vertex_texcoord(m_mesh_art, 0.5, 1.0);
	vertex_normal(m_mesh_art, 0, 0, -1);
	vertex_position_3d(m_mesh_art, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, m_tarotArtDepth);
	vertex_color(m_mesh_art, c_white, 1.0);
	vertex_texcoord(m_mesh_art, 0.0, 1.0);
	vertex_normal(m_mesh_art, 0, 0, -1);	
}
// front face (LABEL):
{
	vertex_position_3d(m_mesh_label, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2 - 1);
	vertex_color(m_mesh_label, c_white, 1.0);
	vertex_texcoord(m_mesh_label, 0.50, 0.0);
	vertex_normal(m_mesh_label, 0, 0, -1);
	vertex_position_3d(m_mesh_label, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2 - 1);
	vertex_color(m_mesh_label, c_white, 1.0);
	vertex_texcoord(m_mesh_label, 1.00, 0.0);
	vertex_normal(m_mesh_label, 0, 0, -1);
	vertex_position_3d(m_mesh_label, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2 - 1);
	vertex_color(m_mesh_label, c_white, 1.0);
	vertex_texcoord(m_mesh_label, 0.50, 1.0);
	vertex_normal(m_mesh_label, 0, 0, -1);

	vertex_position_3d(m_mesh_label, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2 - 1);
	vertex_color(m_mesh_label, c_white, 1.0);
	vertex_texcoord(m_mesh_label, 1.00, 0.0);
	vertex_normal(m_mesh_label, 0, 0, -1);
	vertex_position_3d(m_mesh_label, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2 - 1);
	vertex_color(m_mesh_label, c_white, 1.0);
	vertex_texcoord(m_mesh_label, 1.00, 1.0);
	vertex_normal(m_mesh_label, 0, 0, -1);
	vertex_position_3d(m_mesh_label, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2 - 1);
	vertex_color(m_mesh_label, c_white, 1.0);
	vertex_texcoord(m_mesh_label, 0.50, 1.0);
	vertex_normal(m_mesh_label, 0, 0, -1);
}

// back face:
vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, m_tarotBaseDepth/2);
vertex_color(m_mesh_card, c_white, 1.0);
vertex_texcoord(m_mesh_card, 0.25, 0.0);
vertex_normal(m_mesh_card, 0, 0, 1);
vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, m_tarotBaseDepth/2);
vertex_color(m_mesh_card, c_white, 1.0);
vertex_texcoord(m_mesh_card, 0.50, 0.0);
vertex_normal(m_mesh_card, 0, 0, 1);
vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, m_tarotBaseDepth/2);
vertex_color(m_mesh_card, c_white, 1.0);
vertex_texcoord(m_mesh_card, 0.25, 1.0);
vertex_normal(m_mesh_card, 0, 0, 1);

vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, m_tarotBaseDepth/2);
vertex_color(m_mesh_card, c_white, 1.0);
vertex_texcoord(m_mesh_card, 0.50, 0.0);
vertex_normal(m_mesh_card, 0, 0, 1);
vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, m_tarotBaseDepth/2);
vertex_color(m_mesh_card, c_white, 1.0);
vertex_texcoord(m_mesh_card, 0.50, 1.0);
vertex_normal(m_mesh_card, 0, 0, 1);
vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, m_tarotBaseDepth/2);
vertex_color(m_mesh_card, c_white, 1.0);
vertex_texcoord(m_mesh_card, 0.25, 1.0);
vertex_normal(m_mesh_card, 0, 0, 1);

// create side faces
{
	vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.50, 0.0);
	vertex_normal(m_mesh_card, -1, 0, 0);
	vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.75, 0.0);
	vertex_normal(m_mesh_card, -1, 0, 0);
	vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.50, 1.0);
	vertex_normal(m_mesh_card, -1, 0, 0);

	vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.75, 0.0);
	vertex_normal(m_mesh_card, -1, 0, 0);
	vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.75, 1.0);
	vertex_normal(m_mesh_card, -1, 0, 0);
	vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.50, 1.0);
	vertex_normal(m_mesh_card, -1, 0, 0);
}
{
	vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.50, 0.0);
	vertex_normal(m_mesh_card, +1, 0, 0);
	vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.75, 0.0);
	vertex_normal(m_mesh_card, +1, 0, 0);
	vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.50, 1.0);
	vertex_normal(m_mesh_card, +1, 0, 0);

	vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.75, 0.0);
	vertex_normal(m_mesh_card, +1, 0, 0);
	vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.75, 1.0);
	vertex_normal(m_mesh_card, +1, 0, 0);
	vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.50, 1.0);
	vertex_normal(m_mesh_card, +1, 0, 0);
}
// create top and bottom bits
{
	vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.50, 0.0);
	vertex_normal(m_mesh_card, 0, -1, 0);
	vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.75, 0.0);
	vertex_normal(m_mesh_card, 0, -1, 0);
	vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.50, 1.0);
	vertex_normal(m_mesh_card, 0, -1, 0);

	vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.75, 0.0);
	vertex_normal(m_mesh_card, 0, -1, 0);
	vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.75, 1.0);
	vertex_normal(m_mesh_card, 0, -1, 0);
	vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.50, 1.0);
	vertex_normal(m_mesh_card, 0, -1, 0);
}
{
	vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.50, 0.0);
	vertex_normal(m_mesh_card, 0, +1, 0);
	vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.75, 0.0);
	vertex_normal(m_mesh_card, 0, +1, 0);
	vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.50, 1.0);
	vertex_normal(m_mesh_card, 0, +1, 0);

	vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.75, 0.0);
	vertex_normal(m_mesh_card, 0, +1, 0);
	vertex_position_3d(m_mesh_card, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.75, 1.0);
	vertex_normal(m_mesh_card, 0, +1, 0);
	vertex_position_3d(m_mesh_card, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_mesh_card, c_white, 1.0);
	vertex_texcoord(m_mesh_card, 0.50, 1.0);
	vertex_normal(m_mesh_card, 0, +1, 0);
}

// Finish up all meshes
vertex_end(m_mesh_card);
vertex_freeze(m_mesh_card);

vertex_end(m_mesh_art);
vertex_freeze(m_mesh_art);

vertex_end(m_mesh_label);
vertex_freeze(m_mesh_label);

