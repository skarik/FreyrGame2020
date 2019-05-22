/// @description Interactor

// Inherit the parent event
event_inherited();

// Stop spinning
image_speed = 0;
// Update animation
playerAnimInit();

// Create the interaction object
m_interactionObject = new(o_talkToCharacter);
m_interactionObject.m_owner = id;

#region Per Follower Info

//m_name = "Random Idiot";
//m_interactionFile = "talk00_nathan.txt";

#endregion

// Default sprites
kAnimStanding = sprite_index;
kAnimWalking = sprite_index;