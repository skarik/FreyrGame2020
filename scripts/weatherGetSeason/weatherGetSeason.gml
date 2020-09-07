/// @function weatherGetSeason()
/// @desc Checks the current season of the world.
function weatherGetSeason() {

#macro kWeatherSeasonSummer 0
#macro kWeatherSeasonFall 1
#macro kWeatherSeasonWinter 2
#macro kWeatherSeasonSpring 3

#macro kWeatherSeasonLength 28

	var day = timeofdayGetDay() % (kWeatherSeasonLength * 4);
	if (day < kWeatherSeasonLength)
		return kWeatherSeasonSummer;
	else if (day < kWeatherSeasonLength * 2)
		return kWeatherSeasonFall;
	else if (day < kWeatherSeasonLength * 3)
		return kWeatherSeasonWinter;
	else
		return kWeatherSeasonSpring;



}
