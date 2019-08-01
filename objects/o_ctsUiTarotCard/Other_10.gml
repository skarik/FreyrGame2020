/// @description Set up matrices


// Save old matrix stack
matrix_stack_push(matrix_get(matrix_world));
matrix_stack_push(matrix_get(matrix_view));
matrix_stack_push(matrix_get(matrix_projection));

// Create transformation
var mat_projection = matrix_build_projection_perspective_fov(55, Screen.width / Screen.height, 1, 2000);
var mat_view = matrix_build_lookat(0, 0, -500, 0, 0, 0, 0, -1, 0);
var mat_world = matrix_build(-x, y, z, xrot, yrot, zrot, -1, 1, 1);
matrix_set(matrix_world, mat_world);
matrix_set(matrix_view, mat_view);
matrix_set(matrix_projection, mat_projection);