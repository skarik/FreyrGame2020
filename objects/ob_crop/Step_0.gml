/// @description update grow values

// make sure dirt exists
if (!exists(m_dirt))
{
	m_dirt = collision_point(x, y, o_fieldSquare, true, true);
	
	if (!exists(m_dirt))
	{
		event_user(0); // on destroy
		delete(this);
		exit;
	}
}

// Dirt will always exist by this point

if (m_dirt.watered)
{
	cropSetWateredToday();
}

/*if (timeofdayDidHourPass())
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
}*/
m_growValue = cropGetGrowValue();


var grow_percent = m_growValue / m_growAmountMature;

// update the grow sprite
image_index = max(0.0, ceil((1.0 - grow_percent) * (image_number - 1)));