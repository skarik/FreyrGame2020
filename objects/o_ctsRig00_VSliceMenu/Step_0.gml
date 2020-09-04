/// @description Update control

controlUpdate(false);

// Perform fades
image_alpha = motion1d_to(image_alpha, m_fadeIn ? 1.0 : 0.0, Time.deltaTime);

// Update controls
if (uPosition != uPositionPrevious || vPosition != vPositionPrevious)
{
	m_menuHover = null;
	
	for (var i = 0; i < array_length_1d(menuDrawRects); ++i)
	{
		var t_rect = menuDrawRects[i];
		
		if (point_in_rectangle(uPosition, vPosition,
								t_rect[0], t_rect[1], t_rect[2], t_rect[3]))
		{
			m_menuHover = i;
			break;
		}
	}
}

// Do the description faders
if (m_menuDescriptionSelection != m_menuHover)
{
	m_menuDescriptionAlpha -= Time.deltaTime * 2.0;
	if (m_menuDescriptionAlpha <= 0.0)
	{
		m_menuDescriptionAlpha = 0.0;
		m_menuDescriptionSelection = m_menuHover;
	}
}
else
{
	m_menuDescriptionAlpha = min(1.0, m_menuDescriptionAlpha + Time.deltaTime * 2.0);
}

// Do actions
if (selectButton.pressed || actUiButton.pressed)
{
	if (m_menuHover != null)
	{
		var listingInfo = menuListing[m_menuHover];
		event_user(listingInfo[kiVSliceAction]);
	}
}