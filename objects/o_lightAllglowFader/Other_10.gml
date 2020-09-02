/// @description draw fire light


draw_circle_color(x + xoffset, y + yoffset, m_radius, merge_color(image_blend, c_black, saturate(m_fade)), c_black, false);

// use x + xoffset and y + yoffset
// default blend mode is gpu_set_blendmode_ext(bm_src_alpha, bm_one);