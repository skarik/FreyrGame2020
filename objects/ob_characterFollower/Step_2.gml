/// @description Animation Update

// Inherit the parent event (Depth Update)
event_inherited();

// Update animation
isBusyInteracting = false;
playerAnimLateUpdate();
