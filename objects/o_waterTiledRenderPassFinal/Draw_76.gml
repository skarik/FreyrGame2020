/// @description Update needed surfaces

var game_surface = view_get_surface_id(0);
if (!surface_exists(game_surface))
	exit;

// Create the surfaces needed
if (!surface_exists(surface_tilemapComposite))
{
	surface_tilemapComposite = surface_create(surface_get_width(game_surface), surface_get_height(game_surface));
}
if (!surface_exists(surface_tilemapCompositeBlur))
{
	surface_tilemapCompositeBlur = surface_create(surface_get_width(game_surface), surface_get_height(game_surface));
}

// Sort all the tiled water
var render_queue = ds_priority_create();
with (o_waterTiledRenderPass)
{
	ds_priority_add(render_queue, target_tilemap, layer_get_depth(target_layer));
}

var y_position_offset = 0.0;//round(sin(current_time * 0.0014) * 1.4) - 1;

// Render all the tiled water onto a surface
surface_set_target(surface_tilemapComposite);
draw_clear_alpha(c_black, 0.0);
	while (!ds_priority_empty(render_queue))
	{
		var tilemap_to_render = ds_priority_delete_max(render_queue);
		draw_tilemap(tilemap_to_render, -GameCamera.view_x, -GameCamera.view_y + y_position_offset);
	}
surface_reset_target();

// No need to keep the render queue
ds_priority_destroy(render_queue);

// Render a blurred variant of the tile map
var surface_blurred_temp = surface_create(surface_get_width(game_surface), surface_get_height(game_surface));
shader_set(sh_7tapBlurFilter);
	surface_set_target(surface_blurred_temp);
	shader_set_uniform_f(uBlurPixelInfo, 1.0 / surface_get_width(game_surface), 0.0);
	draw_clear_alpha(c_black, 0.0);
	draw_surface(surface_tilemapComposite, 0, 0);
	surface_reset_target();

	surface_set_target(surface_tilemapCompositeBlur);
	shader_set_uniform_f(uBlurPixelInfo, 0.0, 1.0 / surface_get_height(game_surface));
	draw_clear_alpha(c_black, 0.0);
	draw_surface(surface_blurred_temp, 0, 0);
	surface_reset_target();
shader_reset();
surface_free(surface_blurred_temp);