/// @description Draw frame & door separately - draw frame on top

var width = sprite_get_width(sprite_index);
var height = sprite_get_height(sprite_index);

var uv_left = (m_door_texel_left + 0.1) / width;
var uv_right = (m_door_texel_left + m_door_texel_width - 0.1) / width;
var uv_top = (m_door_texel_top + 0.1) / height;
var uv_bottom = (m_door_texel_top + m_door_texel_height - 0.1) / height;

var px = x + lengthdir_x(m_door_thickness / 2.0, m_doorAngle - 90) * image_xscale - sprite_xoffset + m_door_texel_left * image_xscale;
var py = y + lengthdir_y(m_door_thickness / 2.0, m_doorAngle - 90) - sprite_yoffset + m_door_texel_top + m_door_texel_height - 1;
var ex = px + lengthdir_x(m_door_width, m_doorAngle) * image_xscale;
var ey = py + lengthdir_y(m_door_width, m_doorAngle);

if (m_door_renderFrameBelow)
{
	draw_sprite_ext(
		sprite_index, 2,
		x, y,
		image_xscale, image_yscale, image_angle,
		image_blend, image_alpha);
}

draw_set_color(c_white);
if (m_door_thickness > 0)
{
	draw_primitive_begin_texture(pr_trianglestrip, sprite_get_texture(sprite_index, 0));

	var thickness_offset_x = lengthdir_x(m_door_thickness, m_doorAngle + 90) * image_xscale;
	var thickness_offset_y = lengthdir_y(m_door_thickness, m_doorAngle + 90);
	
	// door outer side
	draw_vertex_texture(ex + thickness_offset_x,
						ey + thickness_offset_y,
						uv_right, uv_bottom);
	draw_vertex_texture(ex,
						ey,
						uv_right, uv_bottom);
	// door top
	draw_vertex_texture(ex + thickness_offset_x,
						ey + thickness_offset_y - m_door_height,
						uv_right, uv_top);
	draw_vertex_texture(ex,
						ey - m_door_height,
						uv_right, uv_top);
	// dummy strip
	draw_vertex_texture(px + thickness_offset_x,
						py + thickness_offset_y  - m_door_height,
						uv_left, uv_top);
	draw_vertex_texture(px,
						py - m_door_height,
						uv_left, uv_top);
	// door inner side
	draw_vertex_texture(px + thickness_offset_x,
						py + thickness_offset_y,
						uv_left, uv_bottom);
	draw_vertex_texture(px,
						py,
						uv_left, uv_bottom);
						
	draw_primitive_end();
}
draw_primitive_begin_texture(pr_trianglestrip, sprite_get_texture(sprite_index, 0));
{
						
	// door front
	draw_vertex_texture(px, py - m_door_height,
						uv_left, uv_top);
	draw_vertex_texture(ex, ey - m_door_height,
						uv_right, uv_top);
	draw_vertex_texture(px, py,
						uv_left, uv_bottom);
	draw_vertex_texture(ex, ey,
						uv_right, uv_bottom);
}
draw_primitive_end();

if (m_door_renderFrameAbove)
{
	draw_sprite_ext(
		sprite_index, 2,
		x, y,
		image_xscale, image_yscale, image_angle,
		image_blend, image_alpha);
}