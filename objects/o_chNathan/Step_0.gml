/// @description follow player

//aiFollowerUpdate();
aiScriptableUpdate();

//x += xspeed * Time.deltaTime;
//y += yspeed * Time.deltaTime;

// Do ground motion
event_inherited();

// disable following if AI is not following. Dont want to have a ton of respawning everywhere
m_isFollowing = m_aiFollowing;