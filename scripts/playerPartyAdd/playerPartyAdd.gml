/// @function playerPartyAdd(member)
/// @desc Add the given NPC to the player party
/// @returns {Boolean} True if added, false if failed to add.

var partyMember = argument0;
partyMember = partyMember.id;

var pl = getPlayer();
if (!iexists(pl)) return false;
var pstats = pl.pstats;
if (!iexists(pstats)) return false;

// is member already in party?
for (var i = 0; i < 3; ++i)
{
	if (pstats.m_party[i] == partyMember)
	{
		// already in party, done
		return true;
	}
}

// find first empty slot
for (var i = 0; i < 3; ++i)
{
	if (pstats.m_party[i] == null)
	{
		pstats.m_party[i] = partyMember;
		return true;
	}
}

// no empty slots, bad state
return false;