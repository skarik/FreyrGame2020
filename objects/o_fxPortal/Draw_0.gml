/*
shader_set(sh_rift);

// Get texture information
var textureAtlasCoords = sprite_get_uvs(sprite_index, 0);
// Set up the shader
shader_set_uniform_f(uni_paletteAtlasCoords,
	textureAtlasCoords[0], textureAtlasCoords[1],
	textureAtlasCoords[2] - textureAtlasCoords[0],
	textureAtlasCoords[3] - textureAtlasCoords[1]);
shader_set_uniform_f(uni_currentTime,
	current_time / 1000.0);

draw_self();
shader_reset();*/

var pl = getPlayer();

var radius = 0.0;
radius = 32.0;
if (exists(pl))
{
	radius *= 0.5 + saturate(1.0 - abs((y - z_height) - (pl.y - pl.z_height)) / 64.0);
}
radius += (radius / 32.0) * sin(current_time * 0.0072) * 1.4;
radius += sin(current_time * 0.00087) * 2.4;
radius = round(radius);

var dx, dy;
dx = x;
dy = round(y - z_height);

draw_set_color(c_black);
draw_circle(dx, dy, radius, false);

draw_set_color(c_white);
draw_circle(dx, dy, radius, true);

// Draw the waterfall
draw_set_color(make_color_rgb(60, 159, 156));
draw_rectangle(dx - 4, dy + radius - 1, dx + 4, y - 8, false);