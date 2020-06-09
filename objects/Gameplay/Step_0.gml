/// @description Run gameplay logic

powerLogicGlobalUpdate();

// Update timescale
var effective_timescale_game = 1.0;
with (ob_timefx)
{
	effective_timescale_game *= m_multiplier;
}

Time.scale = effective_timescale_game * timescale_game * timescale_menu;
if (Time.scale < 1.0 || timescale_previous < 1.0)
{
	// TODO: force update of all audio
	debugOut(string(Time.scale));
}
timescale_previous = Time.scale;

// GAME HACK:
// On the 8th day of each season, create a weather system
var dayOfSeason = (timeofdayGetDay() + timeofdayGetHour() / 24.0) % kWeatherSeasonLength;
var season = weatherGetSeason();

if (worldGameLocationType() & kWorldLocationType_Outdoors)
{
	if (season == kWeatherSeasonSummer)
	{
		if (!iexists(o_weatherSystemSandstorm))
		{
			idelete(ob_weatherSystem);
			inew(o_weatherSystemSandstorm);
		}
		if (iexists(o_snowRenderer))
			idelete(o_snowRenderer);
	}
	else if (season == kWeatherSeasonFall)
	{
		//if (!iexists(o_weatherSystemRockstorm))
		if (!iexists(o_weatherSystemLightningstorm))
		{
			idelete(ob_weatherSystem);
			inew(o_weatherSystemLightningstorm);
		}
		if (iexists(o_snowRenderer))
			idelete(o_snowRenderer);
	}
	else if (season == kWeatherSeasonWinter)
	{
		if (!iexists(o_weatherSystemSnowfall))
		{
			idelete(ob_weatherSystem);
			inew(o_weatherSystemSnowfall);
		}
		if (!iexists(o_snowRenderer))
			inew(o_snowRenderer);
	}
	else if (season == kWeatherSeasonSpring)
	{
		if (!iexists(o_weatherSystemRainstorm))
		{
			idelete(ob_weatherSystem);
			inew(o_weatherSystemRainstorm);
		}
		if (iexists(o_snowRenderer))
			idelete(o_snowRenderer);
	}
}
else
{
	idelete(ob_weatherSystem);
	idelete(o_snowRenderer);
}

if (iexists(ob_weatherSystem))
{
	ob_weatherSystem.m_strength = lerp(kWeatherStrengthZero, kWeatherStrengthLight, saturate(dayOfSeason - 6.0));
	ob_weatherSystem.m_strength = lerp(ob_weatherSystem.m_strength, kWeatherStrengthFull, saturate(dayOfSeason - 13.0));
	ob_weatherSystem.m_strength = lerp(ob_weatherSystem.m_strength, kWeatherStrengthTorrential, saturate(dayOfSeason - 20.0));
	ob_weatherSystem.m_strength = lerp(ob_weatherSystem.m_strength, kWeatherStrengthZero, saturate((dayOfSeason - 25.0) / 2.0));
}

// Update wind audio
windAudioGlobalUpdate();

// Update MLG mode
mlgmodeGlobalUpdate();

// Update slowstep tick
slowstep_tick -= Time.deltaTime;
if (slowstep_tick <= 0.0)
{
	slowstep_tick += Time.deltaTime;
	
	// Perform slow step on all objects that have it.
	with (ob_character)
	{
		event_user(kEvent_ChSlowStep7);
	}
}