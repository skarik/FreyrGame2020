// Reset the grow value
m_growValue = 0;

// Grab the base times
var startTime = m_startDay * 24.0 + m_startHour;
var currentTime = timeofdayGetDay() * 24.0 + timeofdayGetHour();

// Days tick forward at 6AM (6 oclock).
// Nights tick forward at 6PM (18 oclock).

// So, if planted at night, that counts as previous day.
var startDay = floor((startTime - 6.0) / 24.0);
// And if planted at day, that counds as previous night.
var startNight = floor((startTime - 18.0) / 24.0);

// So, we want to loop until the current time:
var gotoDay = floor((currentTime - 6.0) / 24.0) * 24.0;
for (var time = startDay; time < gotoDay; time += 24.0)
{
	var currentDay = floor(time / 24.0);
	
	// Check if was wet/dry that day
	if (!_cropWasWet(currentDay)) {
		m_growValue += m_growAmountDryDay * 12.0;
	}
	else {
		m_growValue += m_growAmountWetDay * 12.0;
	}
}
// Do the same loop for night time:
var gotoNight = floor((currentTime - 18.0) / 24.0) * 24.0;
for (var time = startNight; time < gotoNight; time += 24.0)
{
	var currentNight = floor(time / 24.0);
	
	// Check if was wet/dry that day
	if (!_cropWasWet(currentNight)) { // Wetness check is the same either way.
		m_growValue += m_growAmountDryNight * 12.0;
	}
	else {
		m_growValue += m_growAmountWetNight * 12.0;
	}
}

return m_growValue;