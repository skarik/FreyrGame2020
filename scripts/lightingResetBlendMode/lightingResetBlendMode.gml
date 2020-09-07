/// @function lightingResetBlendMode()
/// @desc Resets the blend mode to the lighting default: bm_src_alpha, bm_one
function lightingResetBlendMode() {
	gpu_set_blendmode_ext(bm_src_alpha, bm_one);


}
