///@function npcIsAngry(npc)
///@param npc
function npcIsAngry(argument0) {

	var npc = argument0;
	if (npc.object_index == o_chGobboTest
		|| npc.object_index == o_chGobboMage
		|| npc.object_index == o_chGobboBomb
		|| npc.object_index == o_chGobboHeavy
		|| npc.object_index == o_chMithraGaurdNpc)
	{
		return npc.m_aiCombat_angry;
	}

	return false;


}
