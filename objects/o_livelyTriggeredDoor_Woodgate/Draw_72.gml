/// @description Set up buffers needed

if (!visible) exit;

if (target_buffer == null || !surface_exists(target_buffer))
{
	target_buffer = surface_create(target_size[0], target_size[1]);
	surface_set_target(target_buffer);
	draw_clear_alpha(c_black, 0.0);

	for (var i = 0; i < door_divCount; ++i)
	{
		var t_lerp = (i / (door_divCount - 1));
		var t_stickPosition = [
			lerp(door_startpoint[0], door_endpoint[0], t_lerp),
			lerp(door_startpoint[1], door_endpoint[1], t_lerp)
			];
		
		/*if (m_wantsOpen)
			t_stickPosition[1] -= smoothstep(m_openBlend) * kGateTravel;
		else
			t_stickPosition[1] -= (1.0 - sqr(1.0 - m_openBlend)) * kGateTravel;*/
		
		draw_sprite(
			s_propSticksLarge,
			0,
			round(t_stickPosition[0] + target_drawoffset[0]),
			round(t_stickPosition[1] + target_drawoffset[1])
			);
	}

	surface_reset_target();
}