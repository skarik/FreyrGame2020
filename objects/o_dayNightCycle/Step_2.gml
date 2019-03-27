/// @description Updates values for the color overlay

// update the time of day
//m_timeOfDay += Time.deltaTime;
var timeOfDayPrev = m_timeOfDay;
m_timeOfDay += Time.deltaTime / 60.0 * 5.0;
// Perform on-the-hour checks
if (frac(m_timeOfDay) < frac(timeOfDayPrev))
{
	m_hourPassed = true;
}
else
{
	m_hourPassed = false;
}
// Loop the time around
if (m_timeOfDay >= 24.00)
{
	m_timeOfDay -= 24.00;
	m_day += 1;
}

if (keyboard_check_pressed(ord("O")))
{
	m_timeOfDay -= 1.0;
	if (m_timeOfDay < 0)
	{
		m_timeOfDay += 24.00;
		m_day -= 1;
	}
}
if (keyboard_check_pressed(ord("P")))
{
	m_timeOfDay += 1.0;
	if (m_timeOfDay >= 24.00)
	{
		m_timeOfDay -= 24.00;
		m_day += 1;
	}
	m_hourPassed = true;
}


// test some day night cycles

var blend0 = 0.0;
var blend1 = 0.0;
blend0 = min(1.0, max(0.0, +sin((m_timeOfDay / 12.0 - 0.5) * 3.14159) * 1.4));
blend1 = min(1.0, max(0.0, -sin((m_timeOfDay / 12.0 - 0.5) * 3.14159) * 1.4));
var color0 = merge_color(make_color_rgb(128, 128, 128), make_color_rgb(255 * 0.6, 180 * 0.6, 60 * 0.6), 1.0 - blend0);
color0 = merge_color(color0, make_color_rgb(90, 70, 255), blend1);


//var kBlendValue = 0.8;
var kBlendValue = 1.0;
//draw_set_color(merge_color(make_color_rgb(128, 128, 128), color0, 0.2));
//draw_rectangle(GameCamera.x - GameCamera.width, GameCamera.y - GameCamera.height, GameCamera.x + GameCamera.width, GameCamera.y + GameCamera.height, false);
m_overlayColor = merge_color(make_color_rgb(128, 128, 128), color0, 1.0 - kBlendValue);

paletteSetMadd2(merge_color(make_color_rgb(128, 128, 128), color0, kBlendValue));
