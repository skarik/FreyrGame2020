/// @description Insert description here
// You can write your code in this editor

if (timeofdayDidHourPass())
{
	var hour = timeofdayGetHour();
	var isDay = (hour > 6.5 && hour < 18.5);
	if (exists(m_dirt) && m_dirt.watered)
	{
		m_growValue += isDay ? m_growAmountWetDay : m_growAmountWetNight;
	}
	else
	{
		m_growValue += isDay ? m_growAmountDryDay : m_growAmountDryNight;
	}
}


var grow_percent = m_growValue / m_growAmountMature;

// update the grow sprite
image_index = max(0.0, ceil((1.0 - grow_percent) * (image_number - 1)));

// make sure dirt exists
if (!exists(m_dirt))
{
	event_user(0);
	delete(this);
}