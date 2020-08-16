/// @description Update the organic behaviors

// Update the cutscene always, regardless
cutsceneUpdate();

var t_jumpToNearby = false;
var t_jumpToAlert = false;
var t_jumpToAngry = false;

// Perform triggers
if (m_triggered && !cutsceneIsDone())
{
	// Check distance interrupt
	if (!m_interruptedNearby && m_interruptOnApporachDistance > 0.0)
	{
		var pl = getPlayer();
		if (iexists(pl))
		{
			var pl_dist_sqr = sqr(x - pl.x) + sqr(y - pl.y);
			if (pl_dist_sqr < sqr(m_interruptOnApporachDistance))
			{
				t_jumpToNearby = true;
				m_interruptedNearby = true;
			}
		}
	}
	
	// Check AI interrupt
	if (m_interruptOnAlert && !m_interruptedAlert)
	{
		for (var i = 0; i < array_length_1d(m_actors); ++i)
		{
			var l_actor = actorGetNpc(m_actors[i]);
			if (iexists(l_actor) && l_actor.m_aiCombat_alerted)
			{
				m_interruptedAlert = true;
				t_jumpToAlert = true;
				break;
			}
		}
	}
	if (m_interruptOnAngry && !m_interruptedAngry)
	{
		for (var i = 0; i < array_length_1d(m_actors); ++i)
		{
			var l_actor = actorGetNpc(m_actors[i]);
			if (iexists(l_actor) && l_actor.m_aiCombat_angry)
			{
				m_interruptedAngry = true;
				t_jumpToAngry = true;
				break;
			}
		}
	}
}

// Perform event jumps.
if (t_jumpToNearby)
{
	if (!cutsceneJumpToLabel("OnInterruptNearby"))
	{
		cutsceneJumpToLabel("OnEnd");
	}
}
if (t_jumpToAlert)
{
	if (!cutsceneJumpToLabel("OnInterruptAlert"))
	{
		cutsceneJumpToLabel("OnEnd");
	}
}
if (t_jumpToAngry)
{
	if (!cutsceneJumpToLabel("OnInterruptAngry"))
	{
		cutsceneJumpToLabel("OnEnd");
	}
}