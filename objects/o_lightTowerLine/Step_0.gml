/// @description update color based on time of day

if (exists(o_dayNightCycle))
{
	image_blend = merge_color(make_color_rgb(80, 80, 70), make_color_rgb(130, 130, 130), o_dayNightCycle.m_blendSunsetToDay);
	image_blend = merge_color(image_blend, make_color_rgb(10, 10, 15), o_dayNightCycle.m_blendSunsetToNight);
}

