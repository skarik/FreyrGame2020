function waterOcclusionColor() {
	//return merge_color(image_blend, c_black, 0.25);

	//#macro c_waterOcclusionSolid make_color_rgb(60, 159, 156);
	//#macro c_waterOcclusionSolid make_color_rgb(24, 63, 57);
	#macro c_waterOcclusionSolid make_color_rgb(255 * (24/60), 255 * (159/63), 255 * (156/57));
	return c_waterOcclusionSolid;


}
