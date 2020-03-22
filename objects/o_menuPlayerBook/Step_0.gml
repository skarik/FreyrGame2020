/// @description Menu update

if (!exists(m_player))
	m_player = getPlayer();

// Menu check:
if (m_player.m_usingBook)
{
	m_totalBlend = min(1.0, m_totalBlend + Time.unscaledDeltaTime * 3.0);
}
else
{
	m_totalBlend = max(0.0, m_totalBlend - Time.unscaledDeltaTime * 3.0);
	if (m_totalBlend <= 0.0)
	{
		delete(this);
		exit; // Skip the rest of the step if deleteed
	}
}

// Update timescale
gameTimescaleMenuSet(sqr(saturate(1.0 - m_totalBlend)));

// Update animation flavors
m_anim_tab_flavor = max(0.0, m_anim_tab_flavor - Time.unscaledDeltaTime * 4.0);

// Only do input if book is front & center
if (m_player.m_usingBook || m_totalBlend == 1.0)
{
	controlUpdate(false);
}
else
{
	controlUpdate(true);
}

// Only do logic if book is front and center
if (m_player.m_usingBook || m_totalBlend == 1.0)
{
	if (journalButton.pressed)
	{
		// Should be handled by the player
	}
	if (cancelButton.pressed)
	{
		if (m_book_state == BookState.TopLevel)
		{
			m_player.m_usingBook = false;
		}
	}
	
	// Do rest & rune options:
	if (m_tab == BookTabs.Main)
	{
		_playeruiBookInputMain();
	}
	else if (m_tab == BookTabs.Map)
	{
		_playeruiBookInputMap();
	}
	else if (m_tab == BookTabs.Options)
	{
		_playeruiBookInputOptions();
	}
	else if (m_tab == BookTabs.Relationship)
	{
		_playeruiBookInputRelationships();
	}
}