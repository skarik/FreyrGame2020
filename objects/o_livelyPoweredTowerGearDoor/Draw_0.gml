/// @description draw the door

// draw the internal holder
draw_sprite_ext(sprite_index, 0,
				x, y,
				image_xscale, 1.0,
				0.0, c_white, 1.0);

// draw the door
draw_sprite_part_ext(sprite_index, 1,
					 0, 0,
					 sprite_get_width(sprite_index),
					 (51 - 43 * (m_openBlend)),
					 x - sprite_xoffset,
					 y - sprite_yoffset + 43 * (m_openBlend),
					 image_xscale, 1.0,
					 c_white, 1.0);
				
// draw the front overlay
/*if (image_number >= 2)
{
	draw_sprite_ext(sprite_index, 2,
					x, y,
					image_xscale, 1.0,
					0.0, c_white, 1.0);
}*/