/// @description temp draw grass

//var pl = getPlayer();

// TODO: prerender the shadow

if (m_shadowTarget == null || !surface_exists(m_shadowTarget))
{
	m_shadowTarget = surface_create(
		m_shadowRect[2] - m_shadowRect[0],
		m_shadowRect[3] - m_shadowRect[1]);
		
	surface_set_target(m_shadowTarget);
	{
		// Clear to white
		draw_clear_alpha(c_white, 0.0);
	
		// Draw in the shadow colors
		gpu_set_alphatestenable(false);
		gpu_set_blendenable(true);
		gpu_set_blendmode_ext_sepalpha(bm_dest_color, bm_zero, bm_one, bm_one);
		draw_set_color(merge_color(merge_color(c_white, c_gold, 0.125), c_black, 0.125));
		for (var i = 0; i < m_grassBitsCount; ++i)
		{
			var i_grass = m_grassBits[i];
			draw_circle(
				i_grass[0] - m_shadowRect[0],
				i_grass[1] - m_shadowRect[1],
				3.5 - i_grass[2] * 0.5, false);
		}
	}
	surface_reset_target();
}

// Draw in the shadow colors
gpu_set_alphatestenable(true);
gpu_set_blendenable(true);
gpu_set_blendmode_ext(bm_dest_color, bm_zero); // Multiply mode
draw_surface(m_shadowTarget, m_shadowRect[0], m_shadowRect[1]);

var wind_information = weatherGetWind();
var wind_factor = wind_information[0];

// Draw the actual grass
gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);
shader_set(sh_wavyGrass);
//texture_set_stage(samplerGrassTexture, sprite_get_texture(s_assetTallGrass, 0));
shader_set_uniform_f(u_animationValues, current_time / 1000.0, sin(current_time / 1000.0), wind_factor, id % 314);
vertex_submit(m_vbuf, pr_trianglelist, sprite_get_texture(s_assetTallGrass, 0));
shader_reset();

