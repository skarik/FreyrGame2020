/// @description Draw time & dithered effect in screen space

if (m_vfxUIGlitch > 0.0)
{
	// Draw the overlay
	gpu_set_blendenable(true);
	draw_set_alpha(m_vfxUIGlitch * 0.3);
	draw_set_color(c_black);
	draw_rectangle(0, 0, Screen.width, Screen.height, false);
	
	// Draw the current time
	draw_set_alpha(m_vfxUIGlitch);
	
	var strHours = string(floor((o_dayNightCycle.m_timeOfDay + 11) % 12 + 1));
	var strMinuteTens = string(floor(frac(o_dayNightCycle.m_timeOfDay) * 6));
	var strMinuteOnes = string(floor(frac(o_dayNightCycle.m_timeOfDay) * 60) % 10);
	var strTimeOfDay = (o_dayNightCycle.m_timeOfDay < 12) ? "AM" : "PM";
	
	var season = weatherGetSeason();
	var day_string = "Spring";
	if (season == kWeatherSeasonSpring)
		day_string = "Spring";
	else if (season == kWeatherSeasonSummer)
		day_string = "Summer";
	else if (season == kWeatherSeasonFall)
		day_string = "Fall";
	else if (season == kWeatherSeasonWinter)
		day_string = "Winter";
	var strCurrentDay = day_string + " " + string((o_dayNightCycle.m_day % kWeatherSeasonLength) + 1);
	
	draw_set_font(global.font_arvo9Bold);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	
	draw_set_color(c_white);
	draw_text_spaced(GameCamera.width / 2.0,
					 GameCamera.height / 2.0 - 2,
					 strHours + ":" + strMinuteTens + strMinuteOnes + " " + strTimeOfDay,
					 3);
					 
	draw_set_valign(fa_top);
	draw_set_font(global.font_arvo8);
	
	draw_set_color(c_white);
	draw_text_spaced(GameCamera.width / 2.0,
					 GameCamera.height / 2.0 + 2,
					 strCurrentDay,
					 2);
	
	// Clean up
	draw_set_alpha(1.0);
}