/// @function _playerInteractOnMissDodge(source)
/// @param source {Object}
function _playerInteractOnMissDodge(argument0) {
	var source = argument0;

	//game_end();
	/*movetype notes:
	- slows time down
	- waits for input for 1.0s real time
	- if no input either returns to normal
	- if input, performs autotracked attack.
	- - moves player to enemy
	- - performs attack
	- - during attack, returns to normal time*/

	debugOut("Perfect dodge!");

	// set moScriptOverride to the new movetype
	if (!m_isKOed && !m_isDead && !m_isStunned)
	{
		moScriptOverride = _playerMotionCounterWait;
		m_perfectCounterTarget = source;
	}


}
