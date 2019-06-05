/// @description Insert description here
// You can write your code in this editor

aiscriptRequestStart(o_chNathan, kAiStyle_Lead);
aiscriptRequestPushPosition(o_chNathan, 400, 600);

var pl;
pl = getPlayer();
if (pl.y > y)
{
	aiscriptRequestStart(o_chNathan, kAiStyle_Follow);

	//m_name = "Nathan";
	/*m_interactChoices = 4;
	m_interaction[0] = "Hello!";
	m_interaction[1] = "Stay here.";
	m_interaction[2] = "(Crafting)";
	m_interaction[3] = "(Leave)";*/
	o_chNathan.m_interactionFile = "talk00_nathan.txt";

	// Create music manager
	new(o_mus00_Oasis);
	
	questSetValue(kQidIntroSequence, 40);
	delete(this);
}