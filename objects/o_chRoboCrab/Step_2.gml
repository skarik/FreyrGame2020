/// @description interact code
// Inherit the parent event
event_inherited(); // animation update

// force update facing direction to match aiming after anim update
facingDirection = aimingDirection;

characterGroundInteractEndStep();