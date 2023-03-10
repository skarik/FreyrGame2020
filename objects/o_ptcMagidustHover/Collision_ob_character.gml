/// @description Insert description here
// You can write your code in this editor

var hit_object = other.id;
if (!iexists(hit_object)) exit;

var delta;
var spd = Time.dt * 110.0;

delta = (hit_object.xspeed * 0.9 - xspeed);
if (abs(delta) < spd)
    xspeed += delta;
else
    xspeed += sign(delta) * spd;
    
delta = (hit_object.yspeed * 0.6 - yspeed);
if (abs(delta) < spd)
    yspeed += delta;
else
    yspeed += sign(delta) * spd;

