/// @description Draw the wall

if (image_angle == 90 || image_angle == 270)
{
	var xscale = (image_angle == 90) ? 1 : -1;
	
	var heightDiv = 5;
	var currentHeight = min(15, m_currentHeight);
	
	var centerScaling = (bbox_bottom - bbox_top - 24) / 16;
	
	for (var i = 2; i >= 0; --i)
	{
		// Skip parts below the height
		if (i * heightDiv > currentHeight)
			continue;
			
		// Calculate split. When past this div, will be limited at height.
		var split = min(heightDiv, currentHeight - i * heightDiv);
		var invSplit = heightDiv - split;
		var yoffset = 16-currentHeight;
		
		// shift when rising
		var xoffset = i - min(2, floor(currentHeight / heightDiv));
		
		// game maker bug
		var xoffset_cut = (xscale == 1) ? 0 : 0.5;
			
		// Draw the piece of the wall, with bottom cut off
		draw_sprite_part_ext(s_effectStoneWallVertical, i,
							 xoffset_cut, 0,
							 16.4, 16,
							 (bbox_left + bbox_right) *0.5 - 8 * xscale + xoffset * xscale,
							 bbox_top - 8 - heightDiv * (2 - i) + yoffset,
							 xscale,
							 1.0,
							 image_blend,
							 image_alpha);
		
		draw_sprite_part_ext(s_effectStoneWallVertical, i,
							 xoffset_cut, 20,
							 16.4, 4,
							 (bbox_left + bbox_right) *0.5 - 8 * xscale + xoffset * xscale,
							 bbox_top + 8 - heightDiv * (2 - i) + yoffset,
							 xscale,
							 centerScaling * (16/4),
							 image_blend,
							 image_alpha);
		
		draw_sprite_part_ext(s_effectStoneWallVertical, i,
							 xoffset_cut, 40 - 16,
							 16.4, 16 - invSplit,
							 (bbox_left + bbox_right) *0.5 - 8 * xscale + xoffset * xscale,
							 bbox_bottom - 16 - heightDiv * (2 - i) + yoffset,
							 xscale,
							 1.0,
							 image_blend,
							 image_alpha);
	}
}
else
{
	var split = 15 - min(15, m_currentHeight);
	var centerScaling = (bbox_right - bbox_left - 32) / 16;
	
	draw_sprite_part_ext(s_effectStoneWallHorizontal, 0,
						 0, 0,
						 16, 24 - split,
						 bbox_left,
						 bbox_bottom - 24 + split,
						 1.0,
						 1.0,
						 image_blend,
						 image_alpha);
						 
	draw_sprite_part_ext(s_effectStoneWallHorizontal, 0,
						 16 - 2, 0,
						 4, 24 - split,
						 bbox_left + 16,
						 bbox_bottom - 24 + split,
						 centerScaling * (16/4),
						 1.0,
						 image_blend,
						 image_alpha);
						 
	draw_sprite_part_ext(s_effectStoneWallHorizontal, 0,
						 32 - 16, 0,
						 16, 24 - split,
						 bbox_right - 16,
						 bbox_bottom - 24 + split,
						 1.0,
						 1.0,
						 image_blend,
						 image_alpha);
						 					 
}