visible = false;

alarm[0] = 1;
m_vbuf = null;

if (!exists(o_tallgrassRendererOverplayer))
{
	new(o_tallgrassRendererOverplayer);
}


m_shadowTarget = null;
m_shadowRect = [0, 0, 0, 0];


var cx1 = x - sprite_get_xoffset(sprite_index) * image_xscale;
var cy1 = y - sprite_get_yoffset(sprite_index) * image_yscale;
var cx2 = x + (-sprite_get_xoffset(sprite_index) + sprite_get_width(sprite_index)) * image_xscale;
var cy2 = y + (-sprite_get_yoffset(sprite_index) + sprite_get_height(sprite_index)) * image_yscale;

m_shadowRect[0] = cx1;
m_shadowRect[1] = cy1;
m_shadowRect[2] = cx2;
m_shadowRect[3] = cy2;

spawnTimer = 0.0;

sprite_prefetch(s_assetTallGrass);