/// @function damageCanHit(source,target)
/// @param source
/// @param target
var source = argument0;
var target = argument1;

if ( !iexists(source) ) {
	return true;
}

// Not self?
if ( source.id != target.id )
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
return false;

