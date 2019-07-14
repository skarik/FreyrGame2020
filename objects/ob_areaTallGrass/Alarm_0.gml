/// @description Set up rendering
visible = true;

var cx1 = x - sprite_get_xoffset(sprite_index) * image_xscale;
var cy1 = y - sprite_get_yoffset(sprite_index) * image_yscale;
var cx2 = x + (-sprite_get_xoffset(sprite_index) + sprite_get_width(sprite_index)) * image_xscale;
var cy2 = y + (-sprite_get_yoffset(sprite_index) + sprite_get_height(sprite_index)) * image_yscale;

// for now, make some doodads of grass
/*for (var ix = cx1; ix < cx2; ix += random_range(4, 8))
{
	for (var iy = cy1; iy < cy2; iy += random_range(4, 8))
	{
		var dx = round(ix + random_range(-2, +2));
		var dy = round(iy + random_range(-2, +2));
		
		// Create a doodad and delete the sprite
		var doodad = instance_create_depth(dx, dy, 0, ob_doodadTreeWiggle);
			doodad.z = collision3_get_highest_position(doodad.x, doodad.y, 0);
			doodad.sprite_index = s_assetTallGrass;
			doodad.image_index = floor(random(sprite_get_number(s_assetTallGrass)));
			doodad.image_speed = 0.0;
			doodad.image_xscale = choose(-1, 1);
			doodad.image_yscale = 1.0;
			doodad.image_angle = 0.0;
			doodad.image_blend = c_white;
			doodad.image_alpha = 1.0
			doodad.collider = null;
	}
}*/

m_grassBits = array_create(0);
m_grassBitsCount = 0;

var grass_sprite = s_assetTallGrass;

for (var ix = cx1; ix < cx2; ix += random_range(2, 6))
{
	for (var iy = cy1; iy < cy2; iy += random_range(2, 6))
	{
		var dx = round(ix + random_range(-2, +2));
		var dy = round(iy + random_range(-2, +2));
		
		if (!position_meeting(dx, dy, id))
		{
			continue;
		}
		
		// Loop through all the other grass and make sure we're not going to double it
		var grass_source = id;
		var grass_collision = false;
		with (ob_areaTallGrass)
		{
			// Skip self, obviously
			if (id == grass_source) continue;
			// Only check with colliding areas for speed
			if (!place_meeting(x, y, grass_source)) continue;
			
			for (var i = 0; i < m_grassBitsCount; ++i)
			{
				var i_grass = m_grassBits[i];
				var dist = sqr(i_grass[0] - dx) + sqr(i_grass[1] - dy);
				if (dist < 20) {
					grass_collision = true;
					break;
				}
			}
			
			if (grass_collision) break;
		}
		
		// Add the grass if no collision!
		if (!grass_collision)
		{
			m_grassBits[m_grassBitsCount] = [dx, dy, floor(random(sprite_get_number(grass_sprite))), choose(-1, 1)];
			m_grassBitsCount += 1;
		}
	}
}