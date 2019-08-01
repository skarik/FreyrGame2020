/// @description Draw tarot cards

var uvs = sprite_get_uvs(sui_tarotTextureStrip, 0);

// Save old matrix stack
matrix_stack_push(matrix_get(matrix_world));
matrix_stack_push(matrix_get(matrix_view));
matrix_stack_push(matrix_get(matrix_projection));

var mat_projection = matrix_build_projection_perspective_fov(55, Screen.width / Screen.height, 1, 2000);
var mat_view = matrix_build_lookat(0, 0, -500, 0, 0, 0, 0, -1, 0);
//var mat_world = matrix_build(GameCamera.width * 0.5, GameCamera.height * 0.5, 0.0, 0, current_time * 0.1, 0, 1, 1, 1);
var mat_world = matrix_build(0, 0, 10.0, 0, current_time * 0.05, current_time * 0.08, 1, 1, 1);
matrix_set(matrix_world, mat_world);
matrix_set(matrix_view, mat_view);
matrix_set(matrix_projection, mat_projection);

// enable depth testing
//gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
//gpu_set_zfunc(cmpfunc_lessequal);

shader_set(sh_tarotCard);
shader_set_uniform_f(uTexSheetCoords, uvs[0], uvs[1], uvs[2] - uvs[0], uvs[3] - uvs[1])
//shader_set_uniform_matrix(uMatrixMVP);

vertex_submit(m_vbuf, pr_trianglelist, sprite_get_texture(sui_tarotTextureStrip, 0));
shader_reset();

gpu_set_ztestenable(false);

// Restore matrix stack
matrix_set(matrix_projection, matrix_stack_top());
matrix_stack_pop();
matrix_set(matrix_view, matrix_stack_top());
matrix_stack_pop();
matrix_set(matrix_world, matrix_stack_top());
matrix_stack_pop();