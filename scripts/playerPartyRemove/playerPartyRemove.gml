/// @function playerPartyRemove(member)
/// @desc Removes the given NPC from the player party
/// @param member {Object} Character to remove
/// @returns {Boolean} True if removed, false if failed to remove.
function playerPartyRemove(argument0) {

	var partyMember = argument0;
	var partyMemberObject = iexists(partyMember) ? partyMember.object_index : partyMember;

	var pl = getPlayer();
	if (!iexists(pl)) return false;
	var pstats = pl.pstats;
	if (!iexists(pstats)) return false;

	// is member already in party?
	if (iexists(partyMember))
	{
		// Grab ID now
		partyMember = partyMember.id;
	
		// Loop through members and check if in the party....
		for (var i = 0; i < 3; ++i)
		{
			if (pstats.m_party[i] == partyMember)
			{
				// already in party, YEETETH
				pstats.m_party[i] = null;
				return true;
			}
		}
	}

	// is member object in the party?
	for (var i = 0; i < 3; ++i)
	{
		if (pstats.m_party[i] != null && pstats.m_party[i].object_index == partyMemberObject)
		{
			// already in party, YEETETH
			pstats.m_party[i] = null;
			return true;
		}
	}

	return false;


}
