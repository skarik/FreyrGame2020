/// @description Inentory and interactor

// Inherit the parent event
event_inherited();

// Stop spinning
image_speed = 0;
// Update animation
playerAnimInit();

// Create the interaction object
m_interactionObject = new(o_talkToCharacter);
m_interactionObject.m_owner = id;

// they need a small inventory, since they are a follower
inventory = inventoryCreateOrLoad(m_name + "#bag", kCountInfinite);
