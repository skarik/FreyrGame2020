isAttacking = true;

if (atkButton.value > 0.707
	&& iexists(m_attackKnockoutTarget)
	&& !m_tookDamage)
{
	// Hold down to choke out
	var l_moveChargePrevious = m_moveCharge;
	m_moveCharge += Time.deltaTime;
	
	// Do sound & effect when KO'd
	if (l_moveChargePrevious < 1.0 && m_moveCharge >= 1.0)
	{
		// Do emote
		var emote_fx = inew(o_fxEmote);
			emote_fx.m_target = m_attackKnockoutTarget;
			emote_fx.image_index = 4;
			
		// Play sound
		effectOnNpcHurt(m_attackKnockoutTarget);
	}
	
	if (m_attackKnockoutTarget.m_canDragOnKnockout)
	{
		// Pull target close
		var t_mask_width = sprite_get_width(sprite_exists(m_attackKnockoutTarget.mask_index) ? m_attackKnockoutTarget.mask_index : m_attackKnockoutTarget.sprite_index);
		var t_result = motion2d_to([m_attackKnockoutTarget.x, m_attackKnockoutTarget.y],
								   [x + lengthdir_x(t_mask_width * 0.5, facingDirection), y + lengthdir_y(t_mask_width * 0.5, facingDirection)],
								   64.0 * Time.deltaTime);
		m_attackKnockoutTarget.x = t_result[0];
		m_attackKnockoutTarget.y = t_result[1];
		m_attackKnockoutTarget.xspeed = 0;
		m_attackKnockoutTarget.yspeed = 0;
		m_attackKnockoutTarget.moEnabled = false;
		m_attackKnockoutTarget.m_aiCombat_enabled = false;
	}
	else
	{
		// TODO: Move player to the target
	}
}
else
{
	if (m_moveCharge >= 1.0 && !m_tookDamage)
	{
		if (iexists(m_attackKnockoutTarget))
		{
			m_attackKnockoutTarget.m_isKOed = true;
			with (m_attackKnockoutTarget)
			{
				event_user(kEvent_ChOnKO0);
			}
		}
	}
	else
	{
		// Notify the AI the choke didn't happen
		if (iexists(m_attackKnockoutTarget))
		{
			m_attackKnockoutTarget.moEnabled = true;
			m_attackKnockoutTarget.m_aiCombat_enabled = true;

			// Update ANGRY trigger. :)
			m_attackKnockoutTarget.m_lastDamageSource = id;
			with (m_attackKnockoutTarget)
			{
				if (m_hasCombatAi)
				{
					if (!m_aiCombat_angry || !iexists(m_aiCombat_target))
					{
						m_aiCombat_target = m_lastDamageSource;
					}
				}
				event_user(kEvent_AIOnAngry12);
			}
		}
	}
	
	isAttacking = false;
	moScriptOverride = null;
}