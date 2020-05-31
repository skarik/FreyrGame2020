/// @description drawwww

if (!iexists(m_target))
	exit;
	
var outliner = id;
with (m_target)
{
	draw_sprite_ext(sprite_index, image_index,
					x - 1, y,
					image_xscale, image_yscale,
					image_angle,
					outliner.image_blend,
					image_alpha * image_alpha);
	draw_sprite_ext(sprite_index, image_index,
					x + 1, y,
					image_xscale, image_yscale,
					image_angle,
					outliner.image_blend,
					image_alpha * image_alpha);
	draw_sprite_ext(sprite_index, image_index,
					x, y - 1,
					image_xscale, image_yscale,
					image_angle,
					outliner.image_blend,
					image_alpha * image_alpha);
	draw_sprite_ext(sprite_index, image_index,
					x, y + 1,
					image_xscale, image_yscale,
					image_angle,
					outliner.image_blend,
					image_alpha * image_alpha);
}