/// @description Draw door (+any powered bits?)

var width = sprite_get_width(sprite_index);
var height = sprite_get_height(sprite_index);

var px = x + lengthdir_x(2, image_angle - 90) * image_xscale;
var py = y;
var ex = px + lengthdir_x(width, image_angle) * image_xscale;
var ey = py + lengthdir_y(width, image_angle);

draw_set_color(c_white);
draw_primitive_begin_texture(pr_trianglestrip, sprite_get_texture(sprite_index, 0));
{
	// door side
	draw_vertex_texture(px + lengthdir_x(2, image_angle + 90) * image_xscale,
						py, 0, 0);
	draw_vertex_texture(px, py, 0, 0);
	// dummy strip
	draw_vertex_texture(px + lengthdir_x(2, image_angle + 90) * image_xscale,
						py - (height - 2) + lengthdir_y(2.0, image_angle + 90), 0, 0);
	draw_vertex_texture(px, py - (height - 2), 1, 0);
	// door top
	draw_vertex_texture(px + lengthdir_x(2, image_angle + 90) * image_xscale,
						py - (height - 2) + lengthdir_y(2.0, image_angle + 90), 0, 0);
	draw_vertex_texture(ex + lengthdir_x(2, image_angle + 90) * image_xscale,
						ey - (height - 2) + lengthdir_y(2.0, image_angle + 90), 1, 0);
	// door front
	draw_vertex_texture(px, py - (height - 2), 0, 2.0 / height);
	draw_vertex_texture(ex, ey - (height - 2), 1, 2.0 / height);
	draw_vertex_texture(px, py, 0, 1);
	draw_vertex_texture(ex, ey, 1, 1);
}
draw_primitive_end();

gpu_set_blendmode(bm_add);
xoffset = 0;
yoffset = 0; 
var prev_glow = m_glowAlpha;
m_glowAlpha = m_glowAlpha * 0.3;
event_user(5);
m_glowAlpha = prev_glow;
gpu_set_blendmode(bm_normal);