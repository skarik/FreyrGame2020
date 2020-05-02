/// @description draw in a 64x64 buffer

var kBufferHSize = 32;
var t_effectBuffer = surface_create(kBufferHSize * 2, kBufferHSize * 2);

surface_set_target(t_effectBuffer);
{
	draw_clear_alpha(c_black, 0.0);
	draw_sprite_ext(sprite_index, image_index, kBufferHSize - 1, kBufferHSize, image_xscale, image_yscale, image_angle, c_black, 1.0);
	draw_sprite_ext(sprite_index, image_index, kBufferHSize + 1, kBufferHSize, image_xscale, image_yscale, image_angle, c_black, 1.0);
	draw_sprite_ext(sprite_index, image_index, kBufferHSize, kBufferHSize - 1, image_xscale, image_yscale, image_angle, c_black, 1.0);
	draw_sprite_ext(sprite_index, image_index, kBufferHSize, kBufferHSize + 1, image_xscale, image_yscale, image_angle, c_black, 1.0);
	draw_sprite_ext(sprite_index, image_index, kBufferHSize, kBufferHSize, image_xscale, image_yscale, image_angle, image_blend, 1.0);
}
surface_reset_target();

draw_set_alpha(1.0);
draw_set_color(c_white);
draw_surface_ext(t_effectBuffer, x - kBufferHSize, y - kBufferHSize, 1.0, 1.0, 0.0, c_white, image_alpha);

surface_free(t_effectBuffer);