/// @description Draw deep glow

shader_set(sh_colorkeyAlphatest);

var ox = x;
var oy = y;
x += xoffset;
y += yoffset;

for (var i = 0; i < 2; ++i)
{
	if (i == 0)
		shader_set_uniform_f(m_locatorSh_uColorKey, 239 / 255.0, 172 / 255.0, 40 / 255.0);
	else
		shader_set_uniform_f(m_locatorSh_uColorKey, 171 / 255.0, 92 / 255.0, 28 / 255.0);
	
	var dx, dy;
	dx = round(x);
	dy = round(y);
	draw_sprite_ext(sprite_index, image_index,
					dx, round(dy - z_height),
					image_xscale, image_yscale,
					image_angle,
					image_blend,
					image_alpha);
}

x = ox;
y = oy;

shader_reset();