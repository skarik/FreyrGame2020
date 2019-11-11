/// @description Draw tilemap

for (var i = 0; i < array_length_1d(global.water_layers); ++i)
{
	draw_tilemap(global.water_layers[i], -GameCamera.view_x, -GameCamera.view_y);
}