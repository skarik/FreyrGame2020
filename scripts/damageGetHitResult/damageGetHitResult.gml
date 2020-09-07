/// @function damageGetHitResult(source,target)
/// @param source
/// @param target
/// @returns {kDamageHitResult}
function damageGetHitResult(argument0, argument1) {
#macro kDamageResultHit				0
#macro kDamageResultMissDodge		1
#macro kDamageResultMissSameTeam	2
#macro kDamageResultMissHitSelf		3
#macro kDamageResultMissEthereal	4

	var source = argument0;
	var target = argument1;

	if ( !iexists(source) )
	{
		return kDamageResultHit;
	}

	// Not self?
	if ( source.id == target.id )
	{
		return kDamageResultMissHitSelf;
	}
	// No teams in common?
	else if ((target.m_team & source.m_team) != 0)
	{
		return kDamageResultMissSameTeam;
	}
	else if (target.isDashing)
	{
		return kDamageResultMissDodge;
	}
	else if (target.isEthereal)
	{
		return kDamageResultMissEthereal;
	}
	else
	{
		return kDamageResultHit;
	}

	/*if ( source.id != target.id )
	{
	    // No teams in common?
	    if ((target.m_team & source.m_team) == 0)
	    {
			if (!target.isDashing && !target.isEthereal)
			{
				return true;
			}
	    }
	}
	return false;*/




}
