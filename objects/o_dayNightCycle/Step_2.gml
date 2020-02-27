/// @description Updates values for the color overlay

//
// update the time of day
//

var timeOfDayPrev = m_timeOfDay;
if (m_timeRunning)
{
	if (Debug.convention_mode)
		m_timeOfDay += Time.deltaTime / 60.0 * 3.0;
	else
		m_timeOfDay += Time.deltaTime / 60.0;// * 5.0;
}
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

// debug junk for moving time forward & back.
if (Debug.visible)
{
	if (keyboard_check_pressed(vk_numpad5))
	{
		m_timeOfDay -= 1.0;
		if (m_timeOfDay < 0)
		{
			m_timeOfDay += 24.00;
			m_day -= 1;
		}
	}
	if (keyboard_check_pressed(vk_numpad6))
	{
		m_timeOfDay += 1.0;
		if (m_timeOfDay >= 24.00)
		{
			m_timeOfDay -= 24.00;
			m_day += 1;
		}
		m_hourPassed = true;
	}
	
	if (keyboard_check_pressed(vk_numpad8))
	{
		m_day -= 1;
	}
	if (keyboard_check_pressed(vk_numpad9))
	{
		m_day += 1;
		m_hourPassed = true;
	}
	
	if (keyboard_check_pressed(vk_numpad4))
	{
		m_day -= 28;
	}
	if (keyboard_check_pressed(vk_numpad7))
	{
		m_day += 28;
		m_hourPassed = true;
	}
}

//
// Generate the day/night cycle colors
//

var blend0 = 0.0; // Daytime blend
var blend1 = 0.0; // Nighttime blend
//blend0 = min(1.0, max(0.0, +sin((m_timeOfDay / 12.0 - 0.5) * 3.14159) * 1.4));	// 1.4 wasn't sharp enough of a blend???
blend0 = min(1.0, max(0.0, +sin((m_timeOfDay / 12.0 - 0.5) * 3.14159) * 3.0));
//blend1 = min(1.0, max(0.0, -sin((m_timeOfDay / 12.0 - 0.5) * 3.14159) * 1.4));
blend1 = min(1.0, max(0.0, -sin((m_timeOfDay / 12.0 - 0.5) * 3.14159) * 2.0));

// Color0 is the blend for the pallete. It is a mulx2 color.
var color0 = merge_color(make_color_rgb(128, 128, 128),						// Daylight (no change)
						 make_color_rgb(255 * 0.6, 180 * 0.6, 60 * 0.6),	// Sunrise/sunset
						 1.0 - blend0);
color0 = merge_color(color0,
					 make_color_rgb(56, 56, 200),							// Nighttime
					 //make_color_rgb(25 * 1.2,25 * 1.2, 112),				// Nighttime
					 blend1);
					 
// Ambient0 is the base lighting value. It is a mulx2 color.
var ambient0 = merge_color(make_color_rgb(128, 128, 128),					// Daylight (fullbright)
						   make_color_rgb(255 * 0.9, 180 * 0.9, 60 * 0.9),	// Sunrise/sunset
						   1.0 - blend0);
ambient0 = merge_color(ambient0,
					   make_color_rgb(9, 7, 26),							// Nighttime
					   blend1);

//
// Save the blends 
// 

m_blendSunsetToDay = blend0;
m_blendSunsetToNight = blend1;

var kBlendValue = 1.0; // Switch between overlay (0.0) and madd2 (1.0). Overlay is in-palette. Madd2 changes the palette itself.
m_overlayColor = merge_color(make_color_rgb(128, 128, 128), color0, 1.0 - kBlendValue);
paletteSetMadd2(merge_color(make_color_rgb(128, 128, 128), color0, kBlendValue));	// This affects te palette
m_ambientLight = ambient0;
