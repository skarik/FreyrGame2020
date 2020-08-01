/// @description OnTrigger

// run transition's code on the player
var pl = getPlayer();

x = pl.x;
y = pl.y;

m_isEdgeTransition = false;
event_perform_object(ob_transitionArea, ev_step, 0);