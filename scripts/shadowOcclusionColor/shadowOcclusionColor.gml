function shadowOcclusionColor()
{
	//return merge_color(image_blend, c_black, 0.25);
#macro c_shadowOcclusionMultiplier make_color_rgb(200, 200, 200); // 78.4%
#macro c_shadowOcclusionPlusSilloMultiplier make_color_rgb(0.784 * 255, 0.784 * 215, 0.784 * 185);
	return c_shadowOcclusionPlusSilloMultiplier;
}
