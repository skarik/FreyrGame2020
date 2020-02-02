/// @description Draw projection

/*draw_set_color(c_white);
draw_set_alpha(0.5);
gpu_set_blendmode(bm_add);

// draw the screen
draw_rectangle(m_targetBase.x + m_projectionLeft,
			   m_targetBase.y + m_projectionTop,
			   m_targetBase.x + m_projectionRight,
			   m_targetBase.y + m_projectionBottom,
			   false);
draw_set_alpha(1.0);*/

draw_set_color(c_white);

draw_set_alpha(1.0);
gpu_set_blendmode(bm_add);

// draw the screen
if (surface_exists(m_bufferProjection))
{
	draw_surface_ext(m_bufferProjection,
					 m_targetBase.x + m_projectionLeft,
					 m_targetBase.y + m_projectionTop,
					 1.0, 1.0, 0.0,
					 c_dkgray, 1.0);
}

// draw the lil triangle for the light emitter

draw_primitive_begin(pr_trianglestrip);

var lerp_val = 64.0 / point_distance(x, y, m_targetBase.x, m_targetBase.y);
for (var i = 0; i < 6; ++i)
{
	var i_pct = i / 5.0;
	var dx = lerp(m_targetBase.x + m_projectionLeft,
				  m_targetBase.x + m_projectionRight, 
				  i_pct);
	dx = lerp(x, dx, lerp_val);
	var dy = lerp(y, m_targetBase.y, lerp_val);
	
	draw_vertex_color(x, y, c_white,
					  0.35 + 0.125 * sin(i * 0.95 + Time.time * 0.4)
					       + 0.125 * sin(i * 2.41 + Time.time * 1.1));
	draw_vertex_color(dx, dy, c_white, 0.0);
}

draw_primitive_end();


// draw the player shadow
gpu_set_blendmode(bm_normal);
/*
var projector = id;
with (getPlayer())
{
	var scale = (projector.y - projector.m_targetBase.y) / (projector.y - y);
	var yblend = 1.0 / scale;
	var line_x = lerp(projector.x, projector.m_targetBase.x, yblend);
	//var line_y = lerp(projector.y, projector.m_targetBase.y, yblend);
	var delta_x = x - line_x;
	
	if (scale > 0.0)
	{
		draw_sprite_ext(sprite_index, image_index,
						projector.m_targetBase.x + delta_x * scale,
						projector.m_targetBase.y,
						scale, scale,
						image_angle,
						c_black,
						0.5);
	}
}
*/