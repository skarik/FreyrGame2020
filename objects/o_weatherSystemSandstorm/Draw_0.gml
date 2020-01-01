/// @description Draw sandstorm overlay

// draw all the sand particles
if (m_dustParticleCount > 0)
{
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	draw_primitive_begin(pr_pointlist);
	
	for (var i = 0; i < m_dustParticleCount; ++i)
	{
		var particle = m_dustParticles[i];
		draw_vertex_color(particle[0], particle[1], particle[4], 1.0);
	}	
	
	draw_primitive_end();
}

// draw the overlays
var alphaStrength = power(max(0.0, m_strength), 0.5);

draw_sprite_tiled_ext(sbg_dustlayer0, 0,
					  m_overlay0_pos[0], m_overlay0_pos[1],
					  1.0, 1.0,
					  c_white, saturate(0.3 * alphaStrength));
					  
draw_sprite_tiled_ext(sbg_dustlayer1, 0,
					  m_overlay1_pos[0], m_overlay1_pos[1],
					  1.0, 1.0,
					  c_white, saturate(0.4 * alphaStrength));