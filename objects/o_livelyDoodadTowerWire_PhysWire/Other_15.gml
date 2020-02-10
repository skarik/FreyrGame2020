/// @description Draw glow

if (!m_meshReady)
	exit;

var t_tex = sprite_get_texture(s_wiresTBase, 0);

shader_set(sh_colormaskExternal);
draw_set_color(c_white);

var mat_world;
var draw_color;

matrix_stack_push(matrix_get(matrix_world));
{
	mat_world = matrix_build(xoffset, yoffset, 0, 0,0,0, 1,1,1);
	matrix_set(matrix_world, mat_world);
	draw_color = merge_color(c_black, emissive.image_blend, emissive.image_alpha);
	shader_set_uniform_f(m_uMultipliedColor, color_get_red(draw_color) / 255.0, color_get_green(draw_color) / 255.0, color_get_blue(draw_color) / 255.0, 1.0);
	vertex_submit(m_mesh, pr_trianglestrip, t_tex);
	
	var draw_offsets_x = [-1, +1, 0,  0,
						  -1, -2, -1,  0, +1, +2, +1,  0];
	var draw_offsets_y = [ 0,  0, -1, +1,
						  -1,  0, +1, +2, +1,  0, -1, -2];
	var draw_offsets_a = [0.15, 0.15, 0.15, 0.15,
						  0.10, 0.05, 0.10, 0.05, 0.10, 0.05, 0.10, 0.05];

	for (var i = 0; i < 12; ++i)
	{
		mat_world = matrix_build(xoffset + draw_offsets_x[i], yoffset + draw_offsets_y[i], 0, 0,0,0, 1,1,1);
		matrix_set(matrix_world, mat_world);
		draw_color = merge_color(c_black, merge_color(c_black, emissive.image_blend, draw_offsets_a[i]), emissive.image_alpha);
		shader_set_uniform_f(m_uMultipliedColor, color_get_red(draw_color) / 255.0, color_get_green(draw_color) / 255.0, color_get_blue(draw_color) / 255.0, 1.0);
		vertex_submit(m_mesh, pr_trianglestrip, t_tex);
	}
}
shader_reset();

matrix_set(matrix_world, matrix_stack_top());
matrix_stack_pop();