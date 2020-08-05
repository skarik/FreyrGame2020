/// @description Draw the portraits in screenspace

//surface_set_target(Screen.m_gameSurface);

var dx = 0;
var dy = 0;

//for (var i = 0; i < kPortraitIndex_Max; ++i)
for (var i = kPortraitIndex_Max - 1; i >= 0; --i)
{
	if (state_sprite[i] != null && state_alpha[i] > 0.0)
	{
		draw_sprite_ext(
			state_sprite[i], 0,
			dx + state_position[i], dy + GameCamera.height,
			state_facing[i], 1.0,
			0.0, c_white,
			state_alpha[i]);
	}
}

//surface_reset_target();