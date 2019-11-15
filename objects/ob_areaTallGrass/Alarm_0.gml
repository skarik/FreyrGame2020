/// @description Set up rendering
visible = true;

var cx1 = x - sprite_get_xoffset(sprite_index) * image_xscale;
var cy1 = y - sprite_get_yoffset(sprite_index) * image_yscale;
var cx2 = x + (-sprite_get_xoffset(sprite_index) + sprite_get_width(sprite_index)) * image_xscale;
var cy2 = y + (-sprite_get_yoffset(sprite_index) + sprite_get_height(sprite_index)) * image_yscale;

m_grassBits = array_create(0);
m_grassBitsCount = 0;

var grass_sprite = s_assetTallGrass;
var grass_width = sprite_get_width(grass_sprite);
var grass_height = sprite_get_height(grass_sprite);

for (var ix = cx1; ix < cx2; ix += random_range(2, 6))
{
	for (var iy = cy1; iy < cy2; iy += random_range(2, 6))
	{
		var dx = round(ix + random_range(-2, +2));
		var dy = round(iy + random_range(-2, +2));
		
		if (!position_meeting(dx, dy, id))
		{
			continue;
		}
		
		// Loop through all the other grass and make sure we're not going to double it
		var grass_source = id;
		var grass_collision = false;
		with (ob_areaTallGrass)
		{
			// Skip self, obviously
			if (id == grass_source) continue;
			// Only check with colliding areas for speed
			if (!place_meeting(x, y, grass_source)) continue;
			
			for (var i = 0; i < m_grassBitsCount; ++i)
			{
				var i_grass = m_grassBits[i];
				var dist = sqr(i_grass[0] - dx) + sqr(i_grass[1] - dy);
				if (dist < 20) {
					grass_collision = true;
					break;
				}
			}
			
			if (grass_collision) break;
		}
		
		// Add the grass if no collision!
		if (!grass_collision)
		{
			m_grassBits[m_grassBitsCount] = [dx, dy, floor(random(sprite_get_number(grass_sprite))), choose(-1, 1)];
			m_grassBitsCount += 1;
		}
	}
}

// Now, create a mesh
vertex_format_begin();
vertex_format_add_position();
//vertex_format_add_colour();
vertex_format_add_custom(vertex_type_float4, vertex_usage_color);
vertex_format_add_texcoord();
m_vformat = vertex_format_end();

m_vbuf = vertex_create_buffer();
vertex_begin(m_vbuf, m_vformat);
for (var i = 0; i < m_grassBitsCount; ++i)
{
	var i_grass = m_grassBits[i];
	var i_grass_uv = sprite_get_uvs(grass_sprite, i_grass[2]);
	var i_grass_width = grass_width * i_grass_uv[6] * i_grass[3];
	var i_grass_height = grass_height * i_grass_uv[7];
	
	// Triangle 1
	vertex_position(m_vbuf, i_grass[0], i_grass[1] - i_grass_height); // 0
	vertex_float4(m_vbuf, i_grass[0], i_grass[1], i, i_grass_height);
	vertex_texcoord(m_vbuf, i_grass_uv[0], i_grass_uv[1]);
	
	vertex_position(m_vbuf, i_grass[0] + i_grass_width, i_grass[1] - i_grass_height); // 1
	vertex_float4(m_vbuf, i_grass[0], i_grass[1], i, i_grass_height);
	vertex_texcoord(m_vbuf, i_grass_uv[2], i_grass_uv[1]);
	
	vertex_position(m_vbuf, i_grass[0], i_grass[1]); // 2
	vertex_float4(m_vbuf, i_grass[0], i_grass[1], i, 0.0);
	vertex_texcoord(m_vbuf, i_grass_uv[0], i_grass_uv[3]);
	
	// Triangle 2
	vertex_position(m_vbuf, i_grass[0], i_grass[1]); // 2
	vertex_float4(m_vbuf, i_grass[0], i_grass[1], i, 0.0);
	vertex_texcoord(m_vbuf, i_grass_uv[0], i_grass_uv[3]);
	
	vertex_position(m_vbuf, i_grass[0] + i_grass_width, i_grass[1] - i_grass_height); // 1
	vertex_float4(m_vbuf, i_grass[0], i_grass[1], i, i_grass_height);
	vertex_texcoord(m_vbuf, i_grass_uv[2], i_grass_uv[1]);
	
	vertex_position(m_vbuf, i_grass[0] + i_grass_width, i_grass[1]); // 3
	vertex_float4(m_vbuf, i_grass[0], i_grass[1], i, 0.0);
	vertex_texcoord(m_vbuf, i_grass_uv[2], i_grass_uv[3]);
	
}
vertex_end(m_vbuf);
vertex_freeze(m_vbuf);

// Get shader stuff
//u_samplerGrassTexture = shader_get_sampler_index(sh_wavyGrass, "samplerGrassTexture");
u_animationValues = shader_get_uniform(sh_wavyGrass, "u_animationValues");