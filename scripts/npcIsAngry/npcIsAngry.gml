///@function npcIsAngry(npc)
///@param npc

var npc = argument0;
if (npc.object_index == o_chGobboTest
	|| npc.object_index == o_chGobboMage
	|| npc.object_index == o_chMithraGaurdNpc)
{
	return npc.m_aiCombat_angry;
}

return false;