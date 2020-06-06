/// @description On KO (health < 0)

// Inherit the parent event
event_inherited();

// No items dropped from small slimes.

// Delete the slime
idelete(this);