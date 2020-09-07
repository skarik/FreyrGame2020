function _gabberBoxHeight() {
	var kMarginTop = iexists(input_actor) ? 10 : 0;
	var kMarginLine = 5;
	var kLineLeeway = 1.6;

	// Set up fonts
	var l_display_font = input_minimal ? display_font_minimal : display_font;
	var l_display_font_height = input_minimal ? display_font_minimal_height : display_font_height;

	draw_set_font(l_display_font);
	var baseHeight = ceil( kMarginTop + l_display_font_height*0.5 + (l_display_font_height + kMarginLine) * ceil(kLineLeeway * (string_width(display_text) + 1) / display_width) );
	return lerp(display_height_old, baseHeight, smoothstep(saturate(display_height_blend)));


}
