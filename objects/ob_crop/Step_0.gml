/// @description update grow values

// make sure dirt exists
if (!iexists(m_dirt))
{
	m_dirt = collision_point(x, y, o_fieldSquare, true, true);
	
	if (!iexists(m_dirt))
	{
		event_user(0); // on destroy
		idelete(this);
		exit;
	}
	else
	{	// Mark owned dirt as planted
		m_dirt.planted = true;
	}
}

// Dirt will always exist by this point

if (m_dirt.watered)
{
	_cropSetWateredToday();
}

/*if (timeofdayDidHourPass())
{
	var hour = timeofdayGetHour();
	var isDay = (hour > 6.5 && hour < 18.5);
	if (iexists(m_dirt) && m_dirt.watered)
	{
		m_growValue += isDay ? m_growAmountWetDay : m_growAmountWetNight;
	}
	else
	{
		m_growValue += isDay ? m_growAmountDryDay : m_growAmountDryNight;
	}
}*/
m_growValue = _cropGetGrowValue();


var grow_percent = m_growValue / m_growAmountMature;

// update the grow sprite
image_index = max(0.0, ceil((1.0 - grow_percent) * (image_number - 1)));

// make visible on timer
if (m_visible_timer > 0.0)
{
	m_visible_timer -= Time.deltaTime;
	if (m_visible_timer <= 0.0)
		visible = true;
}