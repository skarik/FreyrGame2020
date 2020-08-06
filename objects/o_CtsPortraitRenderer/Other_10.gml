/// @description Draw the portraits in screenspace

//surface_set_target(Screen.m_gameSurface);

var dx = 0;
var dy = 0;

//for (var i = 0; i < kPortraitIndex_Max; ++i)
for (var i = kPortraitIndex_Max - 1; i >= 0; --i)
{
	if (state_sprite[i] != null && state_alpha[i] > 0.0)
	{
		var width = sprite_get_width(state_sprite[i]);
		var xoffset = lerp(
			// Left
			width * (0.5 - state_facing[i] * 0.5),
			// Center
			lerp(width * 0.5 * state_facing[i],
				// Right
				-width * (state_facing[i] * 0.5 + 0.5),
				saturate(state_alignment[i])
				),
			saturate(state_alignment[i] + 1.0));
		// Do X/Y fades when fading in and out
		xoffset += width * smoothstep(1.0 - state_alpha[i]) * state_facing[i];
		
		draw_sprite_ext(
			state_sprite[i], 0,
			dx + state_position[i] + xoffset, dy + GameCamera.height,
			sign(state_facing[i]), 1.0,
			0.0, c_white,
			state_alpha[i]);
	}
}

//surface_reset_target();