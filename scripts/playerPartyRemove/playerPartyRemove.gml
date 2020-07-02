/// @function playerPartyRemove(member)
/// @desc Removes the given NPC from the player party
/// @returns {Boolean} True if removed, false if failed to remove.

var partyMember = argument0;
partyMember = partyMember.id;
var partyMemberObject = partyMember.object_index;

var pl = getPlayer();
if (!iexists(pl)) return false;
var pstats = pl.pstats;
if (!iexists(pstats)) return false;

// is member already in party?
for (var i = 0; i < 3; ++i)
{
	if (pstats.m_party[i] == partyMember)
	{
		// already in party, YEETETH
		pstats.m_party[i] = null;
		return true;
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