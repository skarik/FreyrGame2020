/// @description Draw with xoffset/yoffset for lighting

matrix_stack_push(matrix_get(matrix_world));
{
	mat_world = matrix_build(xoffset, yoffset, 0,  0,0,0,  1,1,1);
	matrix_set(matrix_world, mat_world);
	event_user(kEvent_Lighting5);
}
matrix_set(matrix_world, matrix_stack_top());
matrix_stack_pop();