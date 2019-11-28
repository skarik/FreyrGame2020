/// @description Draw the portraits

var dx = GameCamera.view_x;
var dy = GameCamera.view_y;

for (var i = 0; i < kPortraitIndex_Max; ++i)
{
	if (state_sprite[i] != null && state_alpha[i] > 0.0)
	{
		draw_sprite_ext(
			state_sprite[i], 0,
			dx + state_position[i], dy,
			state_facing[i], 1.0,
			0.0, c_white,
			state_alpha[i]);
	}
}