/// @description cutscenePlayerPlayAnimation(target, animation, speed, looped, end_on_finish)
/// @param target
/// @param animation
/// @param speed
/// @param looped
/// @param end_on_finish

var pl = argument0;
var animation_sprite = argument1;
var animation_speed = argument2;
var animation_looped = argument3;
var animation_killdone = argument4;

// Set up the animation
pl.moAnimationPlayback = true;
pl.moAnimationPlaybackLooped = animation_looped;
pl.animationSpeed = animation_speed;
pl.moAnimationPlaybackEndOnFinish = animation_killdone;
pl.animationIndex = 0.0;
pl.image_index = 0.0;
pl.sprite_index = animation_sprite;