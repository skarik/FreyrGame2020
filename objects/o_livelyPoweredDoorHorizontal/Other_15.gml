/// @description Draw glows

if (m_glowAlpha <= 0.01) return;

var width = sprite_get_width(sprite_index);
var height = sprite_get_height(sprite_index);

var px = x + lengthdir_x(2, image_angle - 90) * image_xscale + xoffset;
var py = y + yoffset;
var ex = px + lengthdir_x(width, image_angle) * image_xscale;
var ey = py + lengthdir_y(width, image_angle);

for (var i = 0; i < 4; ++i)
{
	var glow_dist = 3 + i * 0.7;
	var glow_x = lengthdir_x(glow_dist, image_angle - 90) * image_xscale;
	var glow_y = lengthdir_y(glow_dist, image_angle - 90);

	draw_set_color(c_white);
	draw_primitive_begin_texture(pr_trianglestrip, sprite_get_texture(sprite_index, 1));
	{
		// door front
		draw_vertex_texture_color(px + glow_x,
								  py - (height - 2) + glow_y,
								  0, 2.0 / height, c_white, m_glowAlpha);
		draw_vertex_texture_color(ex + glow_x,
								  ey - (height - 2) + glow_y,
								  1, 2.0 / height, c_white, m_glowAlpha);
		draw_vertex_texture_color(px + glow_x,
								  py + glow_y,
								  0, 1, c_white, m_glowAlpha);
		draw_vertex_texture_color(ex + glow_x,
								  ey + glow_y,
								  1, 1, c_white, m_glowAlpha);
	}
	draw_primitive_end();
}