/// @description draw with white outline

shader_set(sh_colormask);
draw_set_color(c_white);
draw_sprite_ext(sprite_index, image_index, x - 1, y - 1, image_xscale, image_yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sprite_index, image_index, x    , y - 1, image_xscale, image_yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sprite_index, image_index, x + 1, y - 1, image_xscale, image_yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sprite_index, image_index, x - 1, y    , image_xscale, image_yscale, image_angle, c_white, image_alpha);
//draw_sprite_ext(sprite_index, image_index, x    , y    , image_xscale, image_yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sprite_index, image_index, x + 1, y    , image_xscale, image_yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sprite_index, image_index, x - 1, y + 1, image_xscale, image_yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sprite_index, image_index, x    , y + 1, image_xscale, image_yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sprite_index, image_index, x + 1, y + 1, image_xscale, image_yscale, image_angle, c_white, image_alpha);
shader_reset();
draw_sprite_ext(sprite_index, image_index, x    , y    , image_xscale, image_yscale, image_angle, c_black, 1.0);