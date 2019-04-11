/// @description init

grow = true;
alpha = 0.0;
radius = 5.0;
color = c_white;

kStartRadius = 5.0;
kEndRadius = 88.0;

// create a buncha bubbles
for (var i = 0; i < 10; ++i)
{
	var angle = random(360);
	var length = random(kStartRadius * 0.66 + kEndRadius * 0.33);
	var bubble = instance_create_depth(x, y, depth + 5, o_fxBubbleUnderwater);
		bubble.x += lengthdir_x(length, angle);
		bubble.y += lengthdir_y(length, angle);
}