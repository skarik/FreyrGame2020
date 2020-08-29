/// @description Interactor

// Inherit the parent event
event_inherited();

// Stop spinning
image_speed = 0;
// Update animation
characterAnimInit();

// Create the interaction object
if (!iexists(m_interactionObject))
{
	m_interactionObject = inew(o_talkToCharacter);
	m_interactionObject.m_owner = id;
}

// update team
m_team = kTeamGood;

#region Per Follower Info

//m_name = "Random Idiot";
//m_interactionFile = "talk00_nathan.txt";
m_wasInteracted = false;
m_isInteractable = true;

#endregion

// Default sprites
kAnimStanding = sprite_index;
kAnimWalking = sprite_index;