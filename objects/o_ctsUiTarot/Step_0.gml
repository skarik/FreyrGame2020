/// @description Update input & logic

if (m_ending)
{
	controlUpdate(true);
}
else
{
	controlUpdate(false);
}

// Fade in the background
if (m_state <= kTarotGameState_FortuneChosen)
{
	m_state_blend_background += Time.deltaTime;
}
else
{
	m_state_blend_background -= Time.deltaTime;
}
m_state_blend_background = saturate(m_state_blend_background);

// Generate the three cards to select from
if (m_state == kTarotGameState_FortuneGenerate)
{
	// Lock player
	cutscenePlayerLock();
	
	// Setup random seed
	var seed_state = mt19937_get_state();
	mt19937_seed(current_time + timeofdayGetTotalHours());

	// Generate a deck
	var deck = ds_list_create();
	for (var i = 0; i < array_length_1d(m_deck); ++i)
		ds_list_add(deck, i);
	
	// Create the three card selection
	for (var i = 0; i < 3; ++i)
	{
		var card_index = mt19937_rand() % ds_list_size(deck);
		m_card_selection[i] = ds_list_find_value(deck, card_index);
		ds_list_delete(deck, card_index);
		
		m_card_flipped[i] = mt19937_rand() % 2;
	}
	
	// No longer need the deck
	ds_list_destroy(deck);
	
	// Update the card sprites
	for (var i = 0; i < 3; ++i)
	{
		var deck_id = m_card_selection[i];
		var card_info = m_deck[deck_id];
		m_card[i].m_tarotArtSprite = card_info[2];
		
		// Create the name
		m_card[i].m_name = "";
		if (card_info[1] == kTarotValueAce)
			m_card[i].m_name += "Ace";
		else
			m_card[i].m_name += string(card_info[1]);
		m_card[i].m_name += " of ";
		if (card_info[0] == kTarotSuitStaves)
			m_card[i].m_name += "Staves";
		else if (card_info[0] == kTarotSuitCups)
			m_card[i].m_name += "Cups";
		else if (card_info[0] == kTarotSuitSwords)
			m_card[i].m_name += "Swords";
		else if (card_info[0] == kTarotSuitRings)
			m_card[i].m_name += "Rings";
	}
	
	// Restore seed state
	mt19937_set_state(seed_state);
	
	m_state = kTarotGameState_FortuneDeal;
}
// Deal the cards out
if (m_state == kTarotGameState_FortuneDeal)
{
	m_state_blend_deal += Time.deltaTime * 0.5;
	
	// Move the cards in
	for (var i = 0; i < 3; ++i)
	{
		var fader = m_state_blend_deal * 2 - i * 0.5;
		fader = saturate(fader);
		
		//var bounce = bouncestep((fader));
		//var bounce2 = smoothstep(1.0 - abs(bounce - 1.0));
		var bounce2 = bounceOut(fader);
		var fallcurve = 1.0 - power(1.0 - fader, 3.0);
		m_card[i].z = lerp(100, 400, bounce2);
		m_card[i].y = lerp(-700, 100 * cos(i - 1), fallcurve);
		m_card[i].x = lerp(0, -400 + 400 * i, fallcurve);
		
		m_card[i].zrot = (i - 1) * 25 + (m_card_flipped[i] ? 180.0 : 0.0);
		// Push rotation
		m_card[i].xrot = 80 * (1.0 - bounce2) * sin(fader * pi * 2.5 + i);
		m_card[i].yrot = 180 + 80 * (1.0 - bounce2) * sin(fader * pi * 4.0 + i * 2);
	}
	
	if (m_state_blend_deal >= 1.0)
	{
		m_state_blend_deal = 1.0;
		m_state = kTarotGameState_FortuneChoose;
	}
}
// Update selection
if (m_state == kTarotGameState_FortuneChoose)
{
	// Change the selection of the card
	if (abs(xAxis.value) > 0.7 && (abs(xAxis.previous) < 0.7 || sign(xAxis.value) != sign(xAxis.previous)))
	{
		if (xAxis.value > 0)
		{
			if (m_state_selection < 2)
			{
				m_state_selection += 1;
				faudio_play_sound(snd_UiMsgBlip, 10, false);
			}
			else
			{
				faudio_play_sound(snd_TypeHit, 10, false);
			}
		}
		else
		{
			if (m_state_selection > 0)
			{
				m_state_selection -= 1;
				faudio_play_sound(snd_UiMsgBlip, 10, false);
			}
			else
			{
				faudio_play_sound(snd_TypeHit, 10, false);
			}
		}
	}
	
	// Fidget with the selected card
	for (var i = 0; i < 3; ++i)
	{
		var target_xrot = 0;
		var target_z = 400;
		if (m_state_selection == i)
		{
			var sine_blend = sin(current_time * 0.006);
			target_xrot = sine_blend * 5 + 15;
			target_z -= 60 + sine_blend * 20;
		}
		if (m_card_flipped[i])
			target_xrot = -target_xrot;
		
		m_card[i].xrot = motion1d_to(m_card[i].xrot, target_xrot, 120 * Time.deltaTime);
		m_card[i].z = motion1d_to(m_card[i].z, target_z, 200 * Time.deltaTime);
	}
	
	// Select a card
	if (selectButton.pressed || useButton.pressed || atkButton.pressed)
	{
		m_state = kTarotGameState_FortuneChosen;
		
		// Save card's initial position for blending
		var i_sel = m_state_selection;
		m_state_select_blend_x = m_card[i_sel].x;
		m_state_select_blend_y = m_card[i_sel].y;
		m_state_select_blend_z = m_card[i_sel].z;
		m_state_select_blend_xrot = m_card[i_sel].xrot;
		m_state_select_blend_yrot = m_card[i_sel].yrot;
		m_state_select_blend_zrot = m_card[i_sel].zrot;
	}
}
// Show selection
if (m_state == kTarotGameState_FortuneChosen)
{
	m_state_blend_select += Time.deltaTime;
	if (m_state_blend_select > 0.5)
		m_state_blend_select_remove += Time.deltaTime;
	if (m_state_blend_select > 1.2)
		m_state_blend_select_continue += Time.deltaTime * 3.0;
	
	var blend = saturate(m_state_blend_select);
	
	var card_idle_xrot = sin(current_time * -0.0021) * 10.0;
	var card_idle_yrot = sin(current_time * -0.0017) * 10.0;
	var card_idle_zrot = sin(current_time * 0.0019) * 5.0;
	
	// Blend the selected card to the center
	var i_sel = m_state_selection;
	m_card[i_sel].x = lerp(m_state_select_blend_x, 0, smoothstep(blend));
	m_card[i_sel].y = lerp(m_state_select_blend_y, 0, smoothstep(blend));
	m_card[i_sel].z = lerp(m_state_select_blend_z, 0, smoothstep(blend));
	m_card[i_sel].xrot = lerp(m_state_select_blend_xrot, card_idle_xrot, smoothstep(blend));
	m_card[i_sel].yrot = lerp(m_state_select_blend_yrot, card_idle_yrot + 360 * 2, bouncestep((smoothstep(blend))));
	m_card[i_sel].zrot = lerp(m_state_select_blend_zrot, card_idle_zrot + (m_card_flipped[i_sel] ? 180.0 : 0.0), smoothstep(blend));
	
	// Move the unselected cards out of view
	for (var i = 0; i < 3; ++i)
	{
		if (i != i_sel)
		{
			// Flip over other cards
			m_card[i].yrot = motion1d_to(m_card[i].yrot, 0, m_state_blend_select * 180.0 * 4 * Time.deltaTime)
			
			// Move them away
			m_card[i].x = motion1d_to(m_card[i].x, 0,  m_state_blend_select_remove * 200.0 * Time.deltaTime);
			m_card[i].y -= m_state_blend_select_remove * 800.0 * Time.deltaTime;
		}
	}
	
	// Continue when done
	if (m_state_blend_select_continue > 1.0)
	{
		if (selectButton.pressed || useButton.pressed || atkButton.pressed)
		{
			// Save player stats
			var pl = getPlayer();
			if (iexists(pl))
			{
				pl.pstats.m_fortune = m_deck[m_card_selection[m_state_selection]];
				pl.pstats.m_fortune_flipped = m_card_flipped[m_state_selection];
			}
			
			m_state = kTarotGameState_FortuneGiven;
		}
	}
}
// Move everything offscreen
if (m_state == kTarotGameState_FortuneGiven)
{
	m_state_blend_select_continue -= Time.deltaTime * 3.0;
	
	// Mark as ending
	m_ending = true;
	
	// Move everything offscreen
	m_state_blend_panout += Time.deltaTime;
	for (var i = 0; i < 3; ++i)
	{
		m_card[i].y -= m_state_blend_panout * 800.0 * Time.deltaTime;
		m_card[i].xrot -= m_state_blend_panout * 360.0 * Time.deltaTime;
		m_card[i].yrot -= m_state_blend_panout * 360.0 * Time.deltaTime;
		m_card[i].zrot -= m_state_blend_panout * 360.0 * Time.deltaTime;
	}
	
	// Once totoally faded, delete self
	if (m_state_blend_panout > 1.0)
	{
		if (!iexists(ob_CtsTalker))
		{
			cutscenePlayerUnlock();
		}
		idelete(this);
	}
}