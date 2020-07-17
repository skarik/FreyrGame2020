/// @description On KO (health < 0)

// Inherit the parent event
event_inherited();

// No items dropped from small slimes.


	
var number_to_drop = choose(0,0,1);
for (var i = 0; i < number_to_drop; ++i)
{
   var angle = random_range(0, 360);
var sped = random_range(140, 180);
        
var item = instance_create_depth(x, y + 16, depth,o_pickupCons_ScorpStick);
    item.z_height = 24;
    item.z = z;
    item.m_pickupSpeedX = lengthdir_x(sped, angle);
    item.m_pickupSpeedY = lengthdir_y(sped, angle);
}


for (var i = 0; i < number_to_drop; ++i)
{
   var angle = random_range(0, 360);
var sped = random_range(140, 180);
        
var item = instance_create_depth(x, y + 16, depth,o_pickupCons_HoneyAbsinthe);
    item.z_height = 24;
    item.z = z;
    item.m_pickupSpeedX = lengthdir_x(sped, angle);
    item.m_pickupSpeedY = lengthdir_y(sped, angle);
}


