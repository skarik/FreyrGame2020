/// @description image speed

event_inherited();
image_speed = 0;

m_team = kTeamGood;

m_name = "Nathan";
m_interactChoices = 4;
m_interaction[0] = "Hello!";
m_interaction[1] = "Stay here.";
m_interaction[2] = "(Crafting)";
m_interaction[3] = "(Leave)";

m_interactionObject = new(o_talkToCharacter);
m_interactionObject.m_owner = id;

aiFollowerInit();