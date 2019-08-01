/// @description Initial state

depth = -9004;

controlInit();

m_ending = false;

m_tarotBaseSprite = sui_tarotTextureBase;
m_tarotBaseWidth = sprite_get_width(m_tarotBaseSprite);
m_tarotBaseHeight = sprite_get_height(m_tarotBaseSprite);
m_tarotBaseDepth = 10;

// Now, create a mesh
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_texcoord();
vertex_format_add_normal();
m_vformat = vertex_format_end();

m_vbuf = vertex_create_buffer();
vertex_begin(m_vbuf, m_vformat);

// front face:
vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
vertex_color(m_vbuf, c_white, 1.0);
vertex_texcoord(m_vbuf, 0.0, 0.0);
vertex_normal(m_vbuf, 0, 0, -1);
vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
vertex_color(m_vbuf, c_white, 1.0);
vertex_texcoord(m_vbuf, 0.25, 0.0);
vertex_normal(m_vbuf, 0, 0, -1);
vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
vertex_color(m_vbuf, c_white, 1.0);
vertex_texcoord(m_vbuf, 0.0, 1.0);
vertex_normal(m_vbuf, 0, 0, -1);

vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
vertex_color(m_vbuf, c_white, 1.0);
vertex_texcoord(m_vbuf, 0.25, 0.0);
vertex_normal(m_vbuf, 0, 0, -1);
vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
vertex_color(m_vbuf, c_white, 1.0);
vertex_texcoord(m_vbuf, 0.25, 1.0);
vertex_normal(m_vbuf, 0, 0, -1);
vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
vertex_color(m_vbuf, c_white, 1.0);
vertex_texcoord(m_vbuf, 0.0, 1.0);
vertex_normal(m_vbuf, 0, 0, -1);

// back face:
vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, m_tarotBaseDepth/2);
vertex_color(m_vbuf, c_white, 1.0);
vertex_texcoord(m_vbuf, 0.25, 0.0);
vertex_normal(m_vbuf, 0, 0, 1);
vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, m_tarotBaseDepth/2);
vertex_color(m_vbuf, c_white, 1.0);
vertex_texcoord(m_vbuf, 0.50, 0.0);
vertex_normal(m_vbuf, 0, 0, 1);
vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, m_tarotBaseDepth/2);
vertex_color(m_vbuf, c_white, 1.0);
vertex_texcoord(m_vbuf, 0.25, 1.0);
vertex_normal(m_vbuf, 0, 0, 1);

vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, m_tarotBaseDepth/2);
vertex_color(m_vbuf, c_white, 1.0);
vertex_texcoord(m_vbuf, 0.50, 0.0);
vertex_normal(m_vbuf, 0, 0, 1);
vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, m_tarotBaseDepth/2);
vertex_color(m_vbuf, c_white, 1.0);
vertex_texcoord(m_vbuf, 0.50, 1.0);
vertex_normal(m_vbuf, 0, 0, 1);
vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, m_tarotBaseDepth/2);
vertex_color(m_vbuf, c_white, 1.0);
vertex_texcoord(m_vbuf, 0.25, 1.0);
vertex_normal(m_vbuf, 0, 0, 1);

// create side faces
{
	vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.50, 0.0);
	vertex_normal(m_vbuf, -1, 0, 0);
	vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.75, 0.0);
	vertex_normal(m_vbuf, -1, 0, 0);
	vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.50, 1.0);
	vertex_normal(m_vbuf, -1, 0, 0);

	vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.75, 0.0);
	vertex_normal(m_vbuf, -1, 0, 0);
	vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.75, 1.0);
	vertex_normal(m_vbuf, -1, 0, 0);
	vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.50, 1.0);
	vertex_normal(m_vbuf, -1, 0, 0);
}
{
	vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.50, 0.0);
	vertex_normal(m_vbuf, +1, 0, 0);
	vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.75, 0.0);
	vertex_normal(m_vbuf, +1, 0, 0);
	vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.50, 1.0);
	vertex_normal(m_vbuf, +1, 0, 0);

	vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.75, 0.0);
	vertex_normal(m_vbuf, +1, 0, 0);
	vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.75, 1.0);
	vertex_normal(m_vbuf, +1, 0, 0);
	vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.50, 1.0);
	vertex_normal(m_vbuf, +1, 0, 0);
}
// create top and bottom bits
{
	vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.50, 0.0);
	vertex_normal(m_vbuf, 0, -1, 0);
	vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.75, 0.0);
	vertex_normal(m_vbuf, 0, -1, 0);
	vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.50, 1.0);
	vertex_normal(m_vbuf, 0, -1, 0);

	vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.75, 0.0);
	vertex_normal(m_vbuf, 0, -1, 0);
	vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.75, 1.0);
	vertex_normal(m_vbuf, 0, -1, 0);
	vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, -m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.50, 1.0);
	vertex_normal(m_vbuf, 0, -1, 0);
}
{
	vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.50, 0.0);
	vertex_normal(m_vbuf, 0, +1, 0);
	vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.75, 0.0);
	vertex_normal(m_vbuf, 0, +1, 0);
	vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.50, 1.0);
	vertex_normal(m_vbuf, 0, +1, 0);

	vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, -m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.75, 0.0);
	vertex_normal(m_vbuf, 0, +1, 0);
	vertex_position_3d(m_vbuf, +m_tarotBaseWidth/2, +m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.75, 1.0);
	vertex_normal(m_vbuf, 0, +1, 0);
	vertex_position_3d(m_vbuf, -m_tarotBaseWidth/2, +m_tarotBaseHeight/2, +m_tarotBaseDepth/2);
	vertex_color(m_vbuf, c_white, 1.0);
	vertex_texcoord(m_vbuf, 0.50, 1.0);
	vertex_normal(m_vbuf, 0, +1, 0);
}

vertex_end(m_vbuf);
vertex_freeze(m_vbuf);


uTexSheetCoords = shader_get_uniform(sh_tarotCard, "uTexSheetCoords");
//uMatrixMVP = shader_get_uniform(sh_tarotCard, "uMatrixMVP");