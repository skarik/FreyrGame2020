/// @function playerPartyGetList()
/// @desc Get list of current party
/// @returns {Array} Current party members
function playerPartyGetList() {

	var pl = getPlayer();
	if (!iexists(pl)) return [];
	var pstats = pl.pstats;
	if (!iexists(pstats)) return [];

	return pstats.m_party;


}
