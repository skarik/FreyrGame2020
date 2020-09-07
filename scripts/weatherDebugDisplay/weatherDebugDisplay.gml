function weatherDebugDisplay() {

	var dx = Screen.width - 160;
	var dy = 16;
	var dw = 160 - 16;

	draw_set_color(c_black);
	draw_set_alpha(0.67);
	draw_rectangle(dx, dy, dx + dw, dy + 64, false);

	draw_set_color(c_white);
	draw_set_alpha(1.0);
	draw_set_font(f_04b03);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	var l_season = "";
	switch (weatherGetSeason())
	{
		case kWeatherSeasonSummer: l_season = "Summer"; break;
		case kWeatherSeasonFall: l_season = "Fall"; break;
		case kWeatherSeasonWinter: l_season = "Winter"; break;
		case kWeatherSeasonSpring: l_season = "Spring"; break;
	}
	draw_text(dx + 4, dy + 4, l_season);
	draw_text(dx + 4, dy + 4 + 8, "weather.strength: " + (iexists(ob_weatherSystem) ? string(ob_weatherSystem.m_strength) : "N/A"));



}
