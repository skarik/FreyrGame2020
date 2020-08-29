/// @description Draw the portraits in screenspace

with (o_CtsPortraitRenderer)
{
	var dx = 0;
	var dy = 0;

	if (state_background != null && state_background_alpha > 0.0)
	{
		draw_sprite_ext(state_background, 0, dx, dy, 1.0, 1.0, 0.0, c_white, state_background_alpha);
	}
}