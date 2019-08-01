/// @description Reset matrices

// Restore matrix stack
matrix_set(matrix_projection, matrix_stack_top());
matrix_stack_pop();
matrix_set(matrix_view, matrix_stack_top());
matrix_stack_pop();
matrix_set(matrix_world, matrix_stack_top());
matrix_stack_pop();