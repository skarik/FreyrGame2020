function playerUiDrawUpperRightAstrolabe() {
	var pl = m_player;
	var dx, dy;

	// time of day (the astrolabe)
	dx = GameCamera.width - 47 - 5;
	dy = 20 - smoothstep(saturate(m_inCutsceneBlend - m_astrolabeForceBlend)) * 200;
	/*
	draw_set_font(f_josefinSlab9);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_set_alpha(1.0);
	//draw_text(dx, dy + 40, string_format(o_dayNightCycle.m_timeOfDay, 4, 2));
	//draw_text(dx, dy + 15, string_format((o_dayNightCycle.m_timeOfDay + 11) % 12 + 1, 4, 2) + " " + ((o_dayNightCycle.m_timeOfDay < 12) ? "AM" : "PM"));
	draw_set_halign(fa_right);
	draw_text(dx - 2, dy, string(floor((o_dayNightCycle.m_timeOfDay + 11) % 12 + 1)));
	draw_set_halign(fa_center);
	draw_text(dx, dy, ":");
	draw_set_halign(fa_right);
	draw_text(dx + 9, dy, string(floor(frac(o_dayNightCycle.m_timeOfDay) * 6)));
	draw_text(dx + 16, dy, string(floor(frac(o_dayNightCycle.m_timeOfDay) * 60) % 10));
	draw_set_halign(fa_left);
	draw_text(dx + 20, dy, (o_dayNightCycle.m_timeOfDay < 12) ? "AM" : "PM");

	draw_text(dx - 5, dy + 12, "Day " + string(o_dayNightCycle.m_day));
	*/
	draw_set_alpha(1.0);
	draw_set_color(c_white);

	dx += 15;
	dy += 25;
	draw_sprite_ext(sui_astrolabeTimeOfDay, 0,
					dx, dy,
					1.0, 1.0,
					o_dayNightCycle.m_timeOfDay / 24.0 * 360.0,
					c_white, 1.0);
	draw_sprite_ext(sui_astrolabeSeason, 0,
					dx, dy,
					1.0, 1.0,
					o_dayNightCycle.m_day / 28.0 * 90.0,
					c_white, 1.0);
	draw_sprite(sui_astrolabeTopper, 0, dx, dy);
	dx -= 15;
	dy -= 25;

	//dx += 45;
	//dy += 2;
	dx += 6;
	dy += -10;
	//draw_set_font(f_04b03);
	draw_set_font(global.font_arvo7);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);

	draw_set_halign(fa_right);
	//draw_text(dx - 2, dy, string(floor((o_dayNightCycle.m_timeOfDay + 11) % 12 + 1)));
	draw_text_spaced(dx - 2, dy, string(floor((o_dayNightCycle.m_timeOfDay + 11) % 12 + 1)), 2);
	draw_set_halign(fa_center);
	draw_text(dx, dy, ":");
	draw_set_halign(fa_right);
	draw_text(dx + 6, dy, string(floor(frac(o_dayNightCycle.m_timeOfDay) * 6)));
	draw_text(dx + 12, dy, string(floor(frac(o_dayNightCycle.m_timeOfDay) * 60) % 10));
	draw_set_halign(fa_left);
	draw_text_spaced(dx + 14, dy, (o_dayNightCycle.m_timeOfDay < 12) ? "AM" : "PM", 2);
	//dx -= 45;
	//dy -= 2;
	dx -= 6;
	dy -= -10;

	dx += 17;
	dy += 36;
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
	day_string = day_string + " " + string((o_dayNightCycle.m_day % kWeatherSeasonLength) + 1);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(global.font_arvo7);
	/*var pen_angle = 190;
	for (var i = 0; i <= string_length(day_string); ++i)
	{
		var str = string_char_at(day_string, i + 1);
		//var angle = 200 + 18 * i;
		pen_angle += string_width(str) / string_width("m") * 35.0;
		//draw_text(dx + lengthdir_x(14, angle),
		//		  dy + lengthdir_y(14, angle),
		//		  str);
		draw_text_ext_transformed(
				dx + lengthdir_x(8, pen_angle),
				dy + lengthdir_y(8, pen_angle),
				str,
				0, 100,
				1.0, 1.0,
				pen_angle - 270);
	}*/
	draw_set_color(c_black);
	draw_text_spaced(dx, dy - 1, day_string, 3);
	draw_text_spaced(dx, dy + 1, day_string, 3);
	draw_text_spaced(dx - 1, dy, day_string, 3);
	draw_text_spaced(dx + 1, dy, day_string, 3);
	draw_set_color(c_white);
	draw_text_spaced(dx, dy, day_string, 3);
	dx -= 17;
	dy -= 36;

	// draw the tarot up there
	dx += 36;
	dy -= 9;
	var fortune = pl.pstats.m_fortune;
	var fortune_flipped = pl.pstats.m_fortune_flipped;
	if (array_length_1d(fortune) > 0)
	{
		var scale = 18/220;
	
		draw_sprite_part_ext(fortune[2],
							 0,
							 0, 0,
							 220, 340,
							 dx + (fortune_flipped ? (220 * scale) : 0.0), dy + (fortune_flipped ? (340 * scale) : 0.0),
							 scale * (fortune_flipped ? -1.0 : 1.0), scale * (fortune_flipped ? -1.0 : 1.0),
							 c_white,
							 1.0);
		draw_sprite_part_ext(sui_tarotTextureStrip,
							 0,
							 0, 0,
							 220, 340,
							 dx + (fortune_flipped ? (220 * scale) : 0.0), dy + (fortune_flipped ? (340 * scale) : 0.0),
							 scale * (fortune_flipped ? -1.0 : 1.0), scale * (fortune_flipped ? -1.0 : 1.0),
							 c_white,
							 1.0);
	}


}
