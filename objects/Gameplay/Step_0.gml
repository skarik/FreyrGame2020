/// @description Run gameplay logic

powerLogicGlobalUpdate();

// GAME HACK:
// On the 8th day of each season, create a weather system
var dayOfSeason = (timeofdayGetDay() + timeofdayGetHour() / 24.0) % kWeatherSeasonLength;
var season = weatherGetSeason();

if (!worldGameIndoors())
{
	if (season == kWeatherSeasonSummer)
	{
		if (!exists(o_weatherSystemSandstorm))
		{
			delete(ob_weatherSystem);
			new(o_weatherSystemSandstorm);
		}
		if (exists(o_snowRenderer))
			delete(o_snowRenderer);
	}
	else if (season == kWeatherSeasonFall)
	{
		//if (!exists(o_weatherSystemRockstorm))
		if (!exists(o_weatherSystemLightningstorm))
		{
			delete(ob_weatherSystem);
			new(o_weatherSystemLightningstorm);
		}
		if (exists(o_snowRenderer))
			delete(o_snowRenderer);
	}
	else if (season == kWeatherSeasonWinter)
	{
		if (!exists(o_weatherSystemSnowfall))
		{
			delete(ob_weatherSystem);
			new(o_weatherSystemSnowfall);
		}
		if (!exists(o_snowRenderer))
			new(o_snowRenderer);
	}
	else if (season == kWeatherSeasonSpring)
	{
		if (!exists(o_weatherSystemRainstorm))
		{
			delete(ob_weatherSystem);
			new(o_weatherSystemRainstorm);
		}
		if (exists(o_snowRenderer))
			delete(o_snowRenderer);
	}
}
else
{
	delete(ob_weatherSystem);
	delete(o_snowRenderer);
}

if (exists(ob_weatherSystem))
{
	ob_weatherSystem.m_strength = lerp(kWeatherStrengthZero, kWeatherStrengthLight, saturate(dayOfSeason - 6.0));
	ob_weatherSystem.m_strength = lerp(ob_weatherSystem.m_strength, kWeatherStrengthFull, saturate(dayOfSeason - 13.0));
	ob_weatherSystem.m_strength = lerp(ob_weatherSystem.m_strength, kWeatherStrengthTorrential, saturate(dayOfSeason - 20.0));
	ob_weatherSystem.m_strength = lerp(ob_weatherSystem.m_strength, kWeatherStrengthZero, saturate((dayOfSeason - 25.0) / 2.0));
}