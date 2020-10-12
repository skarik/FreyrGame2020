/// @description Draw raindrop
/*
if (step < 1)
{
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	draw_primitive_begin(pr_linelist);
		draw_vertex_color(x, y, c_white, 0.0);
		draw_vertex_color(x - wind[0] * 0.4, y - wind[1] * 0.4 - 400, c_white, 1.0);
	draw_primitive_end();
}
else if (step < 2)
{
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	draw_primitive_begin(pr_linelist);
		draw_vertex_color(x, y, c_white, 1.0);
		draw_vertex_color(x - wind[0] * 0.2, y - wind[1] * 0.2 - 120, c_white, 0.0);
	draw_primitive_end();
}
else if (step < 3)
{
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	draw_primitive_begin(pr_linelist);
		draw_vertex_color(x, y, c_white, 1.0);
		draw_vertex_color(x - wind[0] * 0.1, y - wind[1] * 0.1 - 60, c_white, 0.0);
	draw_primitive_end();
}*/