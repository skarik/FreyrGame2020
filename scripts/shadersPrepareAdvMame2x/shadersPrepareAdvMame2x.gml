/// @function shadersPrepareAdvMame2x(sprite_index)
/// @param sprite_index
function shadersPrepareAdvMame2x(argument0) {

	var sprite = argument0;
	var s_bbox = sprite_get_uvs(sprite, 0);

	var s_w = sprite_get_width(sprite) * s_bbox[6];
	var s_h = sprite_get_height(sprite) * s_bbox[7];

	shader_set_uniform_f(global.sh_advMame2x_u_spriteSize, s_w, s_h);
	shader_set_uniform_f(global.sh_advMame2x_u_spriteUVs, s_bbox[0], s_bbox[1], s_bbox[2], s_bbox[3]);



}
